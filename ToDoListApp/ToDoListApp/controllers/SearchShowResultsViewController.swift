//
//  SearchShowResultsViewController.swift
//  ToDoListApp
//
//  Created by desmond on 12/17/14.
//  Copyright (c) 2014 Phoenix. All rights reserved.
//

import UIKit

class SearchShowResultsViewController: TodoListTableViewController,UISearchResultsUpdating {


    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
    }


     func updateSearchResultsForSearchController(searchController: UISearchController) {
       
        if !searchController.active {
            return
        }
        
        filterString = searchController.searchBar.text
        
    }

}
