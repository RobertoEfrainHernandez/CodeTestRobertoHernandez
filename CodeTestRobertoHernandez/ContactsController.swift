//
//  ContactsController.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/18/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class ContactsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavAttributes()
        setUpTableViewAndSearch()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    fileprivate func setNavAttributes() {
        let attributes : [NSAttributedString.Key : Any] = [.foregroundColor : #colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1)]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1)
        
    }
    
    fileprivate func setUpTableViewAndSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        //Table View Attributes
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = #colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1)
        //Search Attributes
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contact"
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.06021262705, green: 0.2616186738, blue: 0.5734841228, alpha: 1)
        searchController.searchBar.searchBarStyle = .minimal
    }

}

extension ContactsController: UISearchBarDelegate, UISearchControllerDelegate {
    
}
