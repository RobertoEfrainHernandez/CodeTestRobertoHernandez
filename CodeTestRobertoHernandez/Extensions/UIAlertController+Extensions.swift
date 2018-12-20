//
//  UIAlertController+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

extension UIAlertController {
    @objc func handleTextChanged() {
        if let first = textFields?[0].text, let last = textFields?[1].text, let phone = textFields?[2].text, let email = textFields?[3].text, let action = actions.last {
            action.isEnabled = !first.isEmpty && !last.isEmpty && !phone.isEmpty && !email.isEmpty
        }
    }
    
    fileprivate func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest.evaluate(with: email)
        return !email.isEmpty && result
    }
    
    fileprivate func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^((0091)|(\\+91)|0?)[6789]{1}\\d{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: phone)
        return !phone.isEmpty && result
    }
}
