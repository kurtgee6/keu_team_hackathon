//
//  HelpVC.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import UIKit
import SVProgressHUD

class HelpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //link which i have to triger https://umasiberia.lib.id/test-service@0.0.0/test_function/

    @IBAction func helpAction(_ sender: Any) {

        if let url = URL(string: "https://umasiberia.lib.id/test-service@0.0.0/test_function/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
 
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

