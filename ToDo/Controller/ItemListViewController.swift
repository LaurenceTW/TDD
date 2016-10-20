//
//  ItemListViewController.swift
//  ToDo
//
//  Created by dasdom on 17.10.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate>!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
}
