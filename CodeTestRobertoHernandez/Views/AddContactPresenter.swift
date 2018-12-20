//
//  AddContactPresenter.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

struct AddContactPresenter {
    let title = "Add your new Contact"
    let actionTitle = "Add Contact"
    let handler : (Contact) -> ()
    
    func present(in viewController: UIViewController) {
        var firstNameField = UITextField()
        var lastNameField = UITextField()
        var phoneField = UITextField()
        var emailField = UITextField()
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter First Name"
            field.addTarget(alert, action: #selector(alert.handleTextChanged), for: .editingChanged)
            firstNameField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Last Name"
            field.addTarget(alert, action: #selector(alert.handleTextChanged), for: .editingChanged)
            lastNameField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Phone Number"
            field.addTarget(alert, action: #selector(alert.handleTextChanged), for: .editingChanged)
            phoneField = field
            phoneField.keyboardType = .phonePad
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Email"
            field.addTarget(alert, action: #selector(alert.handleTextChanged), for: .editingChanged)
            emailField = field
            emailField.keyboardType = .emailAddress
        }
        
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            let newContact = Contact()
            newContact.name = "\(firstNameField.text!) \(lastNameField.text!)"
            newContact.phoneNums.append(phoneField.text!)
            newContact.email.append(emailField.text!)
            newContact.color = UIColor.randomFlat.hexValue()
            self.handler(newContact)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}
