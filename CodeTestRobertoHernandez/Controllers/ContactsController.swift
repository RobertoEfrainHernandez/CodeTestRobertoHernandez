//
//  ContactsController.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/18/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class ContactsController: UITableViewController {
    
    fileprivate let realm = try! Realm()
    fileprivate var contacts : Results<Contact>?
    fileprivate var searchResults : Results<Contact>?
    fileprivate let contrast = ContrastColorOf(#colorLiteral(red: 0, green: 0, blue: 0.2901960784, alpha: 1), returnFlat: true)
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavAttributes()
        setUpTableViewAndSearch()
        loadContacts()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Fileprivate Methods
    
    /* Realm Calls */
    @objc fileprivate func handleAdd() {
        let presenter = AddContactPresenter { [unowned self] (contact) in
            self.save(contact: contact)
        }
        presenter.present(in: self)
    }
    
    fileprivate func loadContacts() {
        contacts = realm.objects(Contact.self)
        searchResults = contacts
        tableView.reloadData()
    }
    
    fileprivate func save(contact: Contact) {
        do {
            try realm.write {
                realm.add(contact)
            }
        } catch {
            print("Error saving contact:", error)
        }
        tableView.reloadData()
    }
    
    fileprivate func delete(contact: Contact) {
        do {
            try realm.write {
                realm.delete(contact)
            }
        } catch {
            print("Error deleting contact:", error)
        }
        tableView.reloadData()
    }
    
    /* Set Up UI for NavBar and Search */
    fileprivate func setNavAttributes() {
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : contrast]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1)
        navigationController?.navigationBar.tintColor = contrast
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    fileprivate func setUpTableViewAndSearch() {
        //Search Attributes
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contact"
        searchController.searchBar.barTintColor = contrast
        searchController.searchBar.tintColor = #colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1)
        searchController.searchBar.searchBarStyle = .minimal
        
        //Table View Attributes
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.5019607843, alpha: 1)
    }
    
    fileprivate func showContactInfo(_ indexPath: IndexPath) {
        let contact = searchResults?[indexPath.row]
        let contactInfo = ContactInfoController()
        contactInfo.contact = contact
        navigationController?.pushViewController(contactInfo, animated: true)
    }

}

//MARK:- Table View Methods

extension ContactsController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "There are currently no Contacts. How about we add some?"
        label.textAlignment = .center
        label.textColor = ContrastColorOf(#colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1), returnFlat: true)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let contacts = contacts {
            return !contacts.isEmpty ? 0 : 250
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactsCell(style: .default, reuseIdentifier: nil)
        
        cell.contact = searchResults?[indexPath.item]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let contacts = contacts {
           delete(contact: contacts[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ContactsCell {
            cell.containerView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.containerView.transform = .identity
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            searchController.dismiss(animated: true) {
                self.showContactInfo(indexPath)
            }
        } else {
            showContactInfo(indexPath)
        }
    }
}

//MARK:- Search Bar Methods

extension ContactsController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        tableView.reloadData()
        if searchText.isEmpty {
            searchResults = contacts
            tableView.reloadData()
            return
        }

        let predicate = NSPredicate(format: "name BEGINSWITH [c]%@", searchText)
        searchResults = realm.objects(Contact.self).filter(predicate).sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchResults = contacts
        tableView.reloadData()
    }
}
