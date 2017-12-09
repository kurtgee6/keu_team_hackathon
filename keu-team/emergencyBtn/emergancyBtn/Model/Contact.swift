//
//  Contact.swift
//  emergancyBtn
//
//  Created by YAUHENI IVANIUK on 12/9/17.
//  Copyright © 2017 YAUHENI IVANIUK. All rights reserved.
//

import Foundation

class Contact {
    private var _name: String
    private var _phone: String
    private var _message: String
    
    var name: String {
        return _name
    }
    
    var phone: String {
        return _phone
    }
    
    var message: String {
        return _message
    }

    
    init(name: String, phone: String, message: String) {
        self._name = name
        self._phone = phone
        self._message = message
    }
}
