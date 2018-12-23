//
//  UIAlertController+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

extension UIAlertController {
    @objc func handleMultipleTextChanged() {
        if let text1 = textFields?[0].text, let text2 = textFields?[1].text, let text3 = textFields?[2].text, let text4 = textFields?[3].text, let action = actions.last {
            action.isEnabled = !text1.isEmpty && !text2.isEmpty && isValidPhone(text3) && isValidEmail(text4)
        }
    }
    
    @objc func handleSingleTextChanged() {
        if let text = textFields?[0].text, let action = actions.last {
            action.isEnabled = !text.isEmpty
        }
    }
    
    @objc func handleSingleTextChangedForPhone() {
        if let text = textFields?[0].text, let action = actions.last {
            action.isEnabled = isValidPhone(text)
        }
    }
    
    @objc func handleSingleTextChangedForEmail() {
        if let text = textFields?[0].text, let action = actions.last {
            action.isEnabled = isValidEmail(text)
        }
    }
    
    @objc func handleDoubleTextChanged() {
        if let text1 = textFields?[0].text, let text2 = textFields?[1].text, let action = actions.last {
            action.isEnabled = !text1.isEmpty && !text2.isEmpty
        }
    }
    
    fileprivate func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let result = emailTest.evaluate(with: email)
        return !email.isEmpty && result
    }
    
    fileprivate func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: phone)
        return !phone.isEmpty && result
    }
}
