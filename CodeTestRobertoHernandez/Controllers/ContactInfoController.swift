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
    fileprivate var phones: List<Phone>?
    fileprivate var emails: List<Email>?
    
    var contact: Contact? {
        didSet {
            phones = contact?.phoneNums
            emails = contact?.emails
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    fileprivate func updateNavBar(_ color: UIColor) {
        let contrast = ContrastColorOf(color, returnFlat: true)
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist")}
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : contrast]
        navBar.barTintColor = color
        navBar.largeTitleTextAttributes = attributes
        navBar.titleTextAttributes = attributes
        navBar.tintColor = contrast
        tableView.backgroundColor = contrast
    }
    
    fileprivate func loadPhoneEmailAddress() {
        
    }
}
