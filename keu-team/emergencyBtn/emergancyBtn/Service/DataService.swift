//
//  DataService.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func saveContactInfo(withUserName name: String, andPhone phone: String, andMessage message: String, contactInfoSaved: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let uuid = UUID().uuidString
        
         let contact = ["name": name, "recipient": phone, "message": message] as [String : Any]
        
        REF_USERS.child(uid).child("contacts").child(uuid).setValue(contact) { (error, ref) in
            guard error == nil else {
                contactInfoSaved(false, error)
                return
            }
            contactInfoSaved(true, nil)
        }
    }
    
//    func getUserPreferencesAndCategorisFromFB(completionHandler: @escaping (_ status: Bool) -> ()) {
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            guard let snapshotData = snapshot.value as? Dictionary<String, Any> else {
//                completionHandler(false)
//                return
//            }
//            guard let preferences = snapshotData[Constants.instance.KEY_UDP_PREFERENCES] as? Dictionary<String, Any> else {
//                completionHandler(false)
//                return
//            }
//            guard let classification = snapshotData[Constants.instance.KEY_UDP_CLASSIFICATION] as? Dictionary<String, Any> else {
//                completionHandler(false)
//                return
//            }
//
//            GetFoodPreference.instance.setUsersPreferenceToUserDefoults(preferences: preferences, classification: classification)
//
//            completionHandler(true)
//
//        }
//
//    }


}
