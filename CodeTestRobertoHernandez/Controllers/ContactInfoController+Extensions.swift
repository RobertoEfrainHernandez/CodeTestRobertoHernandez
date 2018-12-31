//
//  ContactInfoController+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/27/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
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

extension ContactInfoController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func showMail(for indexPath: IndexPath) {
        guard MFMailComposeViewController.canSendMail() else {
            print("This device can't send mail")
            return
        }
        
        let emailComposer = MFMailComposeViewController()
        emailComposer.mailComposeDelegate = self
        
        if let email = emails?[indexPath.row].email {
            emailComposer.setToRecipients([email])
            emailComposer.setSubject("This is from the New Contacts App")
            emailComposer.setMessageBody("Hello,\nThis New Contacts app is so cool, you should try it!", isHTML: false)
        }
        
        present(emailComposer, animated: true)
    }
    
    func showiMessage(for indexPath: IndexPath) {
        guard MFMessageComposeViewController.canSendText() else {
            print("This device can't send iMessages")
            return
        }
        
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        
        if let phoneNumber = phones?[indexPath.row].phoneNumber {
            messageComposer.recipients = [phoneNumber]
            messageComposer.body = "Hello!"
        }
        
        present(messageComposer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let error = error {
            print("Error sending Email:", error.localizedDescription)
            controller.dismiss(animated: true)
            return
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed")
        case .saved:
            print("Saved")
        default:
            print("Sent")
        }
        
        controller.dismiss(animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed")
        default:
            print("Sent")
        }
        
        controller.dismiss(animated: true)
    }
}

extension ContactInfoController {
    func showOpenInMaps(for indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Open in Maps", style: .default, handler: { [unowned self] (_) in
            if let address = self.addresses?[indexPath.row].address {
                self.coordinates(for: address)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    fileprivate func coordinates(for address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Geocoding Error:", error.localizedDescription)
                return
            }
            
            if let location = placemarks?.first?.location?.coordinate {
                self.openMaps(forLat: location.latitude, forLong: location.longitude)
            }
        }
    }
    
    fileprivate func openMaps(forLat lat: Double, forLong long: Double) {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        mapItem.name = contact?.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
