//
//  HelpVC.swift
//  emergencyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation
import FirebaseAuth

//protocol ClassBVCDelegate: class {
//    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double)
//}

class HelpVC: UIViewController{
    
    //link which i have to triger https://umasiberia.lib.id/test-service@0.0.0/test_function/
    
    
    let locationManager = CLLocationManager()
    
    var lat: Double?
    var lon: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        } else {
            print("location error")
        }
        
    }
    
    @IBAction func helpAction(_ sender: Any) {

        
        
        guard let latHere = self.lat, let lonHere = self.lon else {
            return
        }
        
        getAddressFromLatLon(pdblLatitude: latHere, withLongitude: lonHere)
  
        
    }
    
    func callHelp(address: String) {
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        let url = URL(string: "https://keu-team.lib.id/emergency@dev/?")
        
        let request = NSMutableURLRequest(url: url!,
                                          cachePolicy: .reloadIgnoringLocalCacheData,
                                          timeoutInterval: 0.0)
        
        request.httpMethod = "POST"
        
        
        
        let bodyData = "userId=\(userID)&location=\(address)"
        
        request.httpBody = bodyData.data(using: .utf8)
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            
            if (error != nil) {
                print(error!)
            } else {
                
                print("RESPONSe: \(response)")
                
            }
        }
        
        task.resume()
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        let lon: Double = pdblLongitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                var addressString : String = ""
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    if pm.subThoroughfare != nil {
                        addressString = addressString + pm.subThoroughfare! + " "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + " "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    print(addressString)
                    
                    self.callHelp(address: addressString)
                    
                }
                
                
        })
        
    }
    
    
    @IBAction func logOutPressed(_ sender: Any) {
        AuthService.instance.logOut { (status, error) in
            if error == nil {
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "logInVC") as! LogInVC
                
                self.present(controller, animated: true, completion: nil)
            } else {
                if let logInError = error?.localizedDescription {
                    SVProgressHUD.showError(withStatus: logInError)
                }
            }
        }
    }
    
    
    
}

extension HelpVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        SVProgressHUD.showError(withStatus: "Please allow location for app in the settings.")
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            lat =  locations.first?.coordinate.latitude
            lon = locations.first?.coordinate.longitude
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "adressIsReady"), object: nil)
        }
        
    }
    
}

