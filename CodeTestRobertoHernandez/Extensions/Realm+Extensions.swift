//
//  Realm+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/24/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import RealmSwift

fileprivate let realm = try! Realm()

extension Realm {
    
    //MARK:- Saving and Deleting a Contact
    static func save(contact: Contact, table: UITableView) {
        do {
            try realm.write {
                realm.add(contact)
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
        ContactHUD.showSuccess(withStatus: "Contact Added!")
    }
    
    static func delete(contact: Contact, table: UITableView) {
        do {
            try realm.write {
                realm.delete(contact)
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
        ContactHUD.showSuccess(withStatus: "Contact Deleted!")
    }
    
    //MARK:- Methods to use for Selector Methods in ContactInfoController
    static func changeColor(contact: Contact, table: UITableView) {
        do {
            try realm.write {
                contact.color = UIColor.randomFlat.hexValue()
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
    }
    
    static func addBirthday(contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddBirthdayPresenter { (birthday) in
            do {
                try realm.write {
                    contact.birthday = birthday
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Birthday was Updated!")
        }
        presenter.present(in: controller)
    }
    
    static func addPhones(contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddPhonePresenter { (phone) in
            do {
                try realm.write {
                    contact.phoneNums.append(phone)
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Phone Numbers were Updated!")
        }
        presenter.present(in: controller)
    }

    static func addEmails(contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddEmailPresenter { (email) in
            do {
                try realm.write {
                    contact.emails.append(email)
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Emails were Updated!")
        }
        presenter.present(in: controller)
    }

    static func addAddresses(contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddAddressPresenter { (address) in
            do {
                try realm.write {
                    contact.addresses.append(address)
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Addresses were Updated!")
        }
        presenter.present(in: controller)
    }
    
    //MARK:- Deleting Methods
    static func delete(phone: Phone, table: UITableView) {
        do {
            try realm.write {
                realm.delete(phone)
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
        ContactHUD.showSuccess(withStatus: "Phone Number Deleted!")
    }
    
    static func delete(email: Email, table: UITableView) {
        do {
            try realm.write {
                realm.delete(email)
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
        ContactHUD.showSuccess(withStatus: "Email Deleted!")
    }
    
    static func delete(address: Address, table: UITableView) {
        do {
            try realm.write {
                realm.delete(address)
            }
        } catch {
            ContactHUD.showError(withStatus: error.localizedDescription)
        }
        table.reloadData()
        ContactHUD.showSuccess(withStatus: "Address Deleted!")
    }
    
    //MARK:- Editing Methods
    static func edit(phoneIndex: IndexPath, contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddPhonePresenter { (phone) in
            do {
                try realm.write {
                    contact.phoneNums[phoneIndex.row] = phone
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Phone Numbers were Updated!")
        }
        presenter.present(in: controller)
    }
    
    static func edit(emailIndex: IndexPath, contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddEmailPresenter { (email) in
            do {
                try realm.write {
                    contact.emails[emailIndex.row] = email
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Emails were Updated!")
        }
        presenter.present(in: controller)
    }
    
    static func edit(addressIndex: IndexPath, contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = AddAddressPresenter { (address) in
            do {
                try realm.write {
                    contact.addresses[addressIndex.row] = address
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Addresses were Updated!")
        }
        presenter.present(in: controller)
    }
    
    static func handleName(contact: Contact, table: UITableView, controller: UIViewController) {
        let presenter = EditNamePresenter { (name) in
            do {
                try realm.write {
                    contact.name = name
                }
            } catch {
                ContactHUD.showError(withStatus: error.localizedDescription)
            }
            table.reloadData()
            ContactHUD.showSuccess(withStatus: "Contact Name was Updated!")
        }
        presenter.present(in: controller)
    }
}
