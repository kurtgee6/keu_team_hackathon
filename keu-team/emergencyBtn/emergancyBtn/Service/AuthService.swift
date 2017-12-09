//
//  AuthService.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.providerID, "email":user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData as Any as! Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginCompleate: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginCompleate(false, error)
                return
            }
            loginCompleate(true, nil)
        }
    }
    
    func logOut(logOutCompleate: @escaping (_ status: Bool, _ error: Error?) -> ()){
        do {
            try Auth.auth().signOut()
        } catch let logOutError {
            logOutCompleate(false, logOutError)
        }
        
        logOutCompleate(true, nil)
    }
    
}
