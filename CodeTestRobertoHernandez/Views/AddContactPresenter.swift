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
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            firstNameField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Last Name"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            lastNameField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Phone Number"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            phoneField = field
            phoneField.keyboardType = .phonePad
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Email"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            emailField = field
            emailField.keyboardType = .emailAddress
        }
        
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            let newContact = Contact()
            let newPhone = Phone()
            let newEmail = Email()
            newPhone.phoneNumber = phoneField.text!
            newEmail.email = emailField.text!
            newContact.name = "\(firstNameField.text!) \(lastNameField.text!)"
            newContact.phoneNums.append(newPhone)
            newContact.emails.append(newEmail)
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

//MARK:- Add Phone Presenter

struct AddPhonePresenter {
    let title = "Add a new Phone Number"
    let actionTitle = "Add Phone"
    let handler: (Phone) -> ()
    
    func present(in viewController: UIViewController) {
        var phoneField = UITextField()
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            let newPhone = Phone()
            newPhone.phoneNumber = phoneField.text!
            self.handler(newPhone)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter Phone Number"
            field.addTarget(self, action: #selector(alert.handleSingleTextChanged), for: .editingChanged)
            phoneField = field
            phoneField.keyboardType = .phonePad
        }
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}

//MARK:- Add Email Presenter

struct AddEmailPresenter {
    let title = "Add a New Email"
    let actionTitle = "Add Email"
    let handler: (Email) -> ()
    
    func present(in viewController: UIViewController) {
        var emailField = UITextField()
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            let newEmail = Email()
            newEmail.email = emailField.text!
            self.handler(newEmail)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter Email Address"
            field.addTarget(self, action: #selector(alert.handleSingleTextChanged), for: .editingChanged)
            emailField = field
            emailField.keyboardType = .emailAddress
        }
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}

//MARK:- Add Address Presenter

struct AddAddressPresenter {
    let title = "Add a New Address for this Contact"
    let actionTitle = "Add Address"
    let handler : (Address) -> ()
    
    func present(in viewController: UIViewController) {
        var streetField = UITextField()
        var cityField = UITextField()
        var stateField = UITextField()
        var zipField = UITextField()
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter Street"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            streetField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter City"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            cityField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter State"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            stateField = field
        }
        alert.addTextField { (field) in
            field.placeholder = "Enter Zipcode"
            field.addTarget(alert, action: #selector(alert.handleMultipleTextChanged), for: .editingChanged)
            zipField = field
        }
        
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            let newAddress = Address()
            newAddress.address = "\(streetField.text!)\n\(cityField.text!), \(stateField.text!) \(zipField.text!)"
            self.handler(newAddress)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}

//MARK:- Add Birthday Presenter

struct AddBirthdayPresenter {
    let title = "Add a Birthday"
    let actionTitle = "Add Birthday"
    let handler: (String) -> ()
    
    func present(in viewController: UIViewController) {
        var birthdayField = UITextField()
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            self.handler("\(birthdayField.text!)")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter Email Address"
            field.addTarget(self, action: #selector(alert.handleSingleTextChanged), for: .editingChanged)
            birthdayField = field
        }
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}

//MARK:- Edit Name Presenter

struct EditNamePresenter {
    let title = "Edit Contact's Name"
    let actionTitle = "Okay"
    let handler: (String) -> ()
    
    func present(in viewController: UIViewController) {
        var firstField = UITextField()
        var lastField = UITextField()
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let addAction = UIAlertAction(title: actionTitle, style: .default) { (_) in
            self.handler("\(firstField.text!) \(lastField.text!)")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (field) in
            field.placeholder = "Enter First Name"
            field.addTarget(self, action: #selector(alert.handleDoubleTextChanged), for: .editingChanged)
            firstField = field
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Enter Last Name"
            field.addTarget(self, action: #selector(alert.handleDoubleTextChanged), for: .editingChanged)
            lastField = field
        }
        
        addAction.isEnabled = false
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        viewController.present(alert, animated: true)
    }
}


