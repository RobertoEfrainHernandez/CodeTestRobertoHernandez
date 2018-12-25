//
//  ContactsController.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/18/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import RealmSwift

class ContactsController: UITableViewController {
    
    fileprivate let realm = try! Realm()
    fileprivate var contacts : Results<Contact>?
    fileprivate var searchResults : Results<Contact>?
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavAttributes()
        setUpTableViewAndSearch()
        loadContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let searchField = searchController.searchBar.value(forKeyPath: "searchField") as? UITextField
        searchField?.textColor = .mainContrastColor
        searchField?.attributedPlaceholder = NSAttributedString(string: "Search For Contact", attributes: [.foregroundColor : UIColor.mainContrastColor])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetSearchBar(searchController.searchBar)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Fileprivate Methods
    @objc fileprivate func handleAdd() {
        let presenter = AddContactPresenter { [unowned self] (contact) in
            Realm.save(contact, self.tableView)
        }
        presenter.present(in: self)
    }
    
    fileprivate func loadContacts() {
        contacts = realm.objects(Contact.self)
        searchResults = contacts
        tableView.reloadData()
    }
    
    /* Set Up UI for NavBar and Search */
    fileprivate func setNavAttributes() {
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor.mainContrastColor]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .mainColor
        navigationController?.navigationBar.tintColor = .mainContrastColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    fileprivate func setUpTableViewAndSearch() {
        //Search Attributes
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .mainContrastColor
        searchController.searchBar.searchBarStyle = .minimal
        //Table View Attributes
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .mainContrastColor
    }
    
    fileprivate func showContactInfo(_ indexPath: IndexPath) {
        let contact = searchResults?[indexPath.row]
        let contactInfo = ContactInfoController()
        contactInfo.contact = contact
        contactInfo.contactInfoDelegate = self
        navigationController?.pushViewController(contactInfo, animated: true)
    }

}

//MARK:- Table View Methods
extension ContactsController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "There are currently no Contacts. How about we add some?"
        label.textAlignment = .center
        label.textColor = .mainColor
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [unowned self] (_, indexPath) in
            if let contacts = self.contacts {
                Realm.delete(contacts[indexPath.row], self.tableView)
            }
        }
        return [delete]
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ContactsCell {
            cell.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.4, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
        resetSearchBar(searchBar)
    }
    
    fileprivate func resetSearchBar(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchResults = contacts
        tableView.reloadData()
    }
}

//MARK:- Contact Info Delegate Method
extension ContactsController: ContactInfoDelegate {
    func didUpdateContactInfo() {
        tableView.reloadData()
    }
}
