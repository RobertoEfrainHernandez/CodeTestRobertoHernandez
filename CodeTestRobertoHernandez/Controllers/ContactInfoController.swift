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

class ContactInfoController: UITableViewController {
    
    fileprivate let realm = try! Realm()
    fileprivate var phones: Results<Phone>?
    fileprivate var emails: Results<Email>?
    fileprivate var addresses: Results<Address>?
    
    var contact: Contact? {
        didSet {
           loadPhoneEmailAddress()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = contact?.name ?? "John Doe"
        let color = UIColor(hexString: contact?.color ?? "008B8B")!
        title = name
        updateNavBar(color)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateNavBar(#colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1))
    }
    
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
        phones = contact?.phoneNums.sorted(byKeyPath: "phoneNumber", ascending: true)
        emails = contact?.emails.sorted(byKeyPath: "email", ascending: true)
        addresses = contact?.addresses.sorted(byKeyPath: "address", ascending: true)
        tableView.reloadData()
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

extension ContactInfoController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
            cell.infoLabel.text = contact?.name == "" ? "There is no Name" : contact?.name
        case 1:
            cell.infoLabel.text = contact?.birthday == "" ? "Birthday needs to be added" : contact?.birthday
        case 2:
            cell.infoLabel.text = (phones?.isEmpty)! ? "There are no Phone Numbers" : phones?[indexPath.row].phoneNumber
        case 3:
            cell.infoLabel.text = (emails?.isEmpty)! ? "There are no Emails" : emails?[indexPath.row].email
        default:
            cell.infoLabel.text = (addresses?.isEmpty)! ? "There are no Addresses" : addresses?[indexPath.row].address
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
}
