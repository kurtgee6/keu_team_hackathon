//
//  ContactVC.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactVC: UIViewController {

    @IBOutlet weak var contactname: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var messageToSend: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addContactPressed(_ sender: Any) {
        guard contactname.hasText, phoneNumber.hasText, messageToSend.hasText else {
            SVProgressHUD.showError(withStatus: "Check if you put all info!")
            return
        }

        DataService.instance.saveContactInfo(withUserName: contactname.text!, andPhone: phoneNumber.text!, andMessage: messageToSend.text!) { (status, error) in
            if status {
                SVProgressHUD.showSuccess(withStatus: "Contact Saved!")
                self.contactname.text?.removeAll()
                self.phoneNumber.text?.removeAll()
                self.messageToSend.text?.removeAll()
            } else {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
        }
    }
    
}
