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
    
    let realm = try! Realm()
    var contacts : Results<Contact>?
    var filteredContacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavAttributes()
        setUpTableViewAndSearch()
        loadContacts()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Setup Methods
    
    @objc fileprivate func handleAdd() {
        let presenter = AddContactPresenter { [unowned self] (contact) in
            self.save(contact: contact)
        }
        presenter.present(in: self)
    }
    
    fileprivate func loadContacts() {
        contacts = realm.objects(Contact.self)
//        if let contacts = contacts {
//           filteredContacts = Array(contacts)
//        }
        
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
    
    fileprivate func setNavAttributes() {
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : ContrastColorOf(#colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1), returnFlat: true)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1)
        navigationController?.navigationBar.tintColor = ContrastColorOf(#colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1), returnFlat: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    fileprivate func setUpTableViewAndSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        //Table View Attributes
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = #colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1)
        //Search Attributes
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contact"
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1)
        searchController.searchBar.tintColor = ContrastColorOf(#colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1), returnFlat: true)
        searchController.searchBar.searchBarStyle = .minimal
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
        return contacts?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactsCell(style: .default, reuseIdentifier: nil)
        
        cell.contact = contacts?[indexPath.item]
        
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
}

//MARK:- Search Bar Methods

extension ContactsController: UISearchBarDelegate, UISearchControllerDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredContacts = Array(contacts!)
//            tableView.reloadData()
//            return
//        }
//        
//        filteredContacts = Array(contacts!).filter({ (contact) -> Bool in
//            let name = contact.name
//            return name.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = true
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.showsCancelButton = false
//        searchBar.endEditing(true)
//        filteredContacts = Array(contacts!)
//        tableView.reloadData()
//    }
}
