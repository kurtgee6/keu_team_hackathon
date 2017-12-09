//
//  LogInVC.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfUserIn()
    }
    
    func checkIfUserIn() {
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                // do something
                self.performSegue(withIdentifier: "toMainUpSegue", sender: self)
            }
        }
    }
    
    
    @IBAction func signInBtn(_ sender: Any) {
        guard emailText.hasText, passwordText.hasText else {
            SVProgressHUD.showError(withStatus: "Please check your passsword and email.")
            return
        }
        AuthService.instance.loginUser(withEmail: emailText.text!, andPassword: passwordText.text!) { (success, logInError) in
            if success {
                self.emailText.text?.removeAll()
                self.passwordText.text?.removeAll()
                
                self.performSegue(withIdentifier: "toMainUpSegue", sender: self)
                
            } else {
                AuthService.instance.registerUser(withEmail: self.emailText.text!, andPassword: self.passwordText.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        self.performSegue(withIdentifier: "toMainUpSegue", sender: self)
                        
                    } else {
                        if let logInError = registrationError?.localizedDescription {
                            SVProgressHUD.showError(withStatus: logInError)
                        }
                    }
                })
            }
            
        }
    }
    
}
