//
//  ContactInfoController.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

protocol ContactInfoDelegate {
    func didUpdateContactInfo()
}

class ContactInfoController: UITableViewController {
    
    //MARK:- Properties
    fileprivate let realm = try! Realm()
    fileprivate var phones: List<Phone>?
    fileprivate var emails: List<Email>?
    fileprivate var addresses: List<Address>?
    
    var contactInfoDelegate: ContactInfoDelegate?
    var contact: Contact? {
        didSet {
           loadPhoneEmailAddress()
        }
    }
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Color", style: .plain, target: self, action: #selector(handleColorChanged))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = contact?.name ?? "John Doe"
        let color = UIColor(hexString: contact?.color ?? "008B8B")!
        title = name
        updateNavBar(color)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateNavBar(.mainColor)
    }
    
    //MARK:- Fileprivate and Selector Methods
    fileprivate func setTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    fileprivate func updateNavBar(_ color: UIColor) {
        let contrast = ContrastColorOf(color, returnFlat: true)
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist")}
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : contrast]
        navBar.barTintColor = color
        navBar.largeTitleTextAttributes = attributes
        navBar.titleTextAttributes = attributes
        navBar.tintColor = contrast
    }
    
    fileprivate func loadPhoneEmailAddress() {
        phones = contact?.phoneNums
        emails = contact?.emails
        addresses = contact?.addresses
        tableView.reloadData()
    }
    
    @objc fileprivate func handleColorChanged() {
        if let currentContact = self.contact {
            do {
                try self.realm.write {
                    currentContact.color = UIColor.randomFlat.hexValue()
                }
            } catch {
                print("Error saving new Color:", error)
            }
        }
        let color = UIColor(hexString: contact?.color ?? "008B8B")!
        updateNavBar(color)
        tableView.reloadData()
        contactInfoDelegate?.didUpdateContactInfo()
    }
    
    @objc fileprivate func handlePhones() {
        let presenter = AddPhonePresenter { [unowned self] (phone) in
            if let currentContact = self.contact {
                do {
                    try self.realm.write {
                        currentContact.phoneNums.append(phone)
                    }
                } catch {
                    print("Error saving new Email Address:", error)
                }
            }
            self.tableView.reloadData()
        }
        presenter.present(in: self)
    }
    
    @objc fileprivate func handleEmails() {
        let presenter = AddEmailPresenter { [unowned self] (email) in
            if let currentContact = self.contact {
                do {
                    try self.realm.write {
                        currentContact.emails.append(email)
                    }
                } catch {
                    print("Error saving new Email Address:", error)
                }
            }
            self.tableView.reloadData()
        }
        presenter.present(in: self)
    }
    
    @objc fileprivate func handleBirthday() {
        let presenter = AddBirthdayPresenter { [unowned self] (birthday) in
            if let currentContact = self.contact {
                do {
                    try self.realm.write {
                        currentContact.birthday = birthday
                    }
                } catch {
                    print("Error saving Birthday:", error)
                }
            }
            self.tableView.reloadData()
        }
        presenter.present(in: self)
    }
    
    @objc fileprivate func handleAddresses() {
        let presenter = AddAddressPresenter { [unowned self] (address) in
            if let currentContact = self.contact {
                do {
                    try self.realm.write {
                        currentContact.addresses.append(address)
                    }
                } catch {
                    print("Error saving new Address:", error)
                }
            }
            self.tableView.reloadData()
        }
        presenter.present(in: self)
    }
}

//MARK:- Extension for TableView Methods

extension ContactInfoController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        switch section {
        case 0:
            view.headerLabel.text = "Name"
            view.addButton.isEnabled = false
            view.addButton.isHidden = true
        case 1:
            view.headerLabel.text = "Birthday"
            if contact?.birthday == "" {
              view.addButton.addTarget(self, action: #selector(handleBirthday), for: .touchUpInside)
            } else {
                view.addButton.isEnabled = false
                view.addButton.isHidden = true
            }
        case 2:
            view.headerLabel.text = "Phones"
            view.addButton.addTarget(self, action: #selector(handlePhones), for: .touchUpInside)
        case 3:
            view.headerLabel.text = "Emails"
            view.addButton.addTarget(self, action: #selector(handleEmails), for: .touchUpInside)
        default:
            view.headerLabel.text = "Addresses"
            view.addButton.addTarget(self, action: #selector(handleAddresses), for: .touchUpInside)
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return phones?.count ?? 1
        case 3:
            return emails?.count ?? 1
        default:
            return addresses?.count ?? 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactInfoCell(style: .default, reuseIdentifier: nil)
        let color = UIColor(hexString: contact?.color ?? "008B8B")!
        cell.container.backgroundColor = color
        cell.infoLabel.textColor = ContrastColorOf(color, returnFlat: true)
        
        switch indexPath.section {
        case 0:
            cell.infoLabel.text = (contact?.name == "" || contact?.name == nil) ? "There is no Name" : contact?.name
        case 1:
            cell.infoLabel.text = (contact?.birthday == "" || contact?.birthday == nil) ? "Birthday needs to be added" : contact?.birthday
        case 2:
            cell.infoLabel.text = ((phones?.isEmpty)! || phones == nil) ? "There are no Phone Numbers" : phones?[indexPath.row].phoneNumber
        case 3:
            cell.infoLabel.text = ((emails?.isEmpty)! || emails == nil) ? "There are no Emails" : emails?[indexPath.row].email
        default:
            cell.infoLabel.text = ((addresses?.isEmpty)! || addresses == nil) ? "There are no Addresses" : addresses?[indexPath.row].address
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteEntity(indexPath)
            self.contactInfoDelegate?.didUpdateContactInfo()
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.editEntity(indexPath)
            self.contactInfoDelegate?.didUpdateContactInfo()
        }
        let color = UIColor(hexString: contact?.color ?? "008B8B")!
        edit.backgroundColor = color
        if (indexPath.section == 0 || indexPath.section == 1) {
            return [edit]
        }
        
        return [delete, edit]
    }
}

//MARK:- Extension for Deleting and Editing Methods for TableViewRowAction
extension ContactInfoController {
    fileprivate func deleteEntity(_ indexPath: IndexPath) {
        if let phones = phones, let emails = emails, let addresses = addresses {
            switch indexPath.section {
            case 2:
                Realm.delete(phone: phones[indexPath.row], tableView)
            case 3:
                Realm.delete(email: emails[indexPath.row], tableView)
            default:
                Realm.delete(address: addresses[indexPath.row], tableView)
            }
        }
    }
    
    fileprivate func editEntity(_ indexPath: IndexPath) {
        if let currentContact = contact {
            switch indexPath.section {
            case 0:
                Realm.handleName(currentContact, tableView, self)
            case 1:
                handleBirthday()
            case 2:
                Realm.edit(phoneIndex: indexPath, currentContact, tableView, self)
            case 3:
                Realm.edit(emailIndex: indexPath, currentContact, tableView, self)
            default:
                Realm.edit(addressIndex: indexPath, currentContact, tableView, self)
            }
        }
    }
}
