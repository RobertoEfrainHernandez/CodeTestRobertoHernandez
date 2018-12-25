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
    static func save(_ contact: Contact, _ tableView: UITableView) {
        do {
            try realm.write {
                realm.add(contact)
            }
        } catch {
            print("Error saving contact:", error)
        }
        tableView.reloadData()
    }
    
    static func delete(_ contact: Contact, _ tableView: UITableView) {
        do {
            try realm.write {
                realm.delete(contact)
            }
        } catch {
            print("Error deleting contact:", error)
        }
        tableView.reloadData()
    }
    
    //MARK:- Methods to use for Selector Methods in ContactInfoController
    static func changeColor(_ contact: Contact, _ tableView: UITableView) {
        do {
            try realm.write {
                contact.color = UIColor.randomFlat.hexValue()
            }
        } catch {
            print("Error saving new Color:", error)
        }
        tableView.reloadData()
    }
    
    static func addBirthday(_ contact: Contact, _ tableView: UITableView, _ viewController: UIViewController) {
        let presenter = AddBirthdayPresenter { (birthday) in
            do {
                try realm.write {
                    contact.birthday = birthday
                }
            } catch {
                print("Error saving Birthday:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewController)
    }
    
    static func addPhones(_ contact: Contact, _ tableView: UITableView, _ viewController: UIViewController) {
        let presenter = AddPhonePresenter { (phone) in
            do {
                try realm.write {
                    contact.phoneNums.append(phone)
                }
            } catch {
                print("Error saving new Email Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewController)
    }

    static func addEmails(_ contact: Contact, _ tableView: UITableView, _ viewController: UIViewController) {
        let presenter = AddEmailPresenter { (email) in
            do {
                try realm.write {
                    contact.emails.append(email)
                }
            } catch {
                print("Error saving new Email Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewController)
    }

    static func addAddresses(_ contact: Contact, _ tableView: UITableView, _ viewController: UIViewController) {
        let presenter = AddAddressPresenter { (address) in
            do {
                try realm.write {
                    contact.addresses.append(address)
                }
            } catch {
                print("Error saving new Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewController)
    }
    
    //MARK:- Deleting Methods
    static func delete(phone: Phone, _ tableView: UITableView) {
        do {
            try realm.write {
                realm.delete(phone)
            }
        } catch {
            print("Error deleting Phone Numder:", error)
        }
        tableView.reloadData()
    }
    
    static func delete(email: Email, _ tableView: UITableView) {
        do {
            try realm.write {
                realm.delete(email)
            }
        } catch {
            print("Error deleting Email Address:", error)
        }
        tableView.reloadData()
    }
    
    static func delete(address: Address, _ tableView: UITableView) {
        do {
            try realm.write {
                realm.delete(address)
            }
        } catch {
            print("Error deleting Address:", error)
        }
        tableView.reloadData()
    }
    
    //MARK:- Editing Methods
    static func edit(phoneIndex: IndexPath, _ contact: Contact, _ tableView: UITableView, _ viewControler: UIViewController) {
        let presenter = AddPhonePresenter { (phone) in
            do {
                try realm.write {
                    contact.phoneNums[phoneIndex.row] = phone
                }
            } catch {
                print("Error saving new Email Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewControler)
    }
    
    static func edit(emailIndex: IndexPath, _ contact: Contact, _ tableView: UITableView, _ viewControler: UIViewController) {
        let presenter = AddEmailPresenter { (email) in
            do {
                try realm.write {
                    contact.emails[emailIndex.row] = email
                }
            } catch {
                print("Error saving new Email Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewControler)
    }
    
    static func edit(addressIndex: IndexPath, _ contact: Contact, _ tableView: UITableView, _ viewControler: UIViewController) {
        let presenter = AddAddressPresenter { (address) in
            do {
                try realm.write {
                    contact.addresses[addressIndex.row] = address
                }
            } catch {
                print("Error saving new Address:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewControler)
    }
    
    static func handleName(_ contact: Contact, _ tableView: UITableView, _ viewController: UIViewController) {
        let presenter = EditNamePresenter { (name) in
            do {
                try realm.write {
                    contact.name = name
                }
            } catch {
                print("Error saving Name:", error)
            }
            tableView.reloadData()
        }
        presenter.present(in: viewController)
    }
}
