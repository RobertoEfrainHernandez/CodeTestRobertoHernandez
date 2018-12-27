//
//  ContactInfoController+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/27/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

extension ContactInfoController {
    
    //MARK:- Selector Methods
    @objc fileprivate func handlePhones() {
        if let currentContact = contact {
            Realm.addPhones(contact: currentContact, table: tableView, controller: self)
        }
    }
    
    @objc fileprivate func handleEmails() {
        if let currentContact = contact {
            Realm.addEmails(contact: currentContact, table: tableView, controller: self)
        }
    }
    
    @objc fileprivate func handleAddresses() {
        if let currentContact = contact {
            Realm.addAddresses(contact: currentContact, table: tableView, controller: self)
        }
    }
    
    //MARK:- Methods used in TableView Delegate and Datasource
    func setNumberRows(for section: Int) -> Int {
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
    
    func setHeaderView(for section: Int) -> UIView {
        let view = HeaderView()
        switch section {
        case 0:
            view.headerLabel.text = "Name"
            view.addButton.isEnabled = false
            view.addButton.isHidden = true
        case 1:
            view.headerLabel.text = "Birthday"
            view.addButton.isEnabled = false
            view.addButton.isHidden = true
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
    
    func setUpCell(for contactInfoCell: ContactInfoCell, color: UIColor, indexPath: IndexPath) {
        contactInfoCell.container.backgroundColor = color
        contactInfoCell.infoLabel.textColor = ContrastColorOf(color, returnFlat: true)
        switch indexPath.section {
        case 0:
            contactInfoCell.infoLabel.text = (contact?.name == "" || contact?.name == nil) ? "There is no Name" : contact?.name
        case 1:
            contactInfoCell.infoLabel.text = (contact?.birthday == "" || contact?.birthday == nil) ? "Birthday needs to be added" : contact?.birthday
        case 2:
            contactInfoCell.infoLabel.text = ((phones?.isEmpty)! || phones == nil) ? "There are no Phone Numbers" : phones?[indexPath.row].phoneNumber
        case 3:
            contactInfoCell.infoLabel.text = ((emails?.isEmpty)! || emails == nil) ? "There are no Emails" : emails?[indexPath.row].email
        default:
            contactInfoCell.infoLabel.text = ((addresses?.isEmpty)! || addresses == nil) ? "There are no Addresses" : addresses?[indexPath.row].address
        }
    }
}
