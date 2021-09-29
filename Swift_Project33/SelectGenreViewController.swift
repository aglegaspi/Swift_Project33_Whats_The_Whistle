//
//  SelectGenreViewController.swift
//  Swift_Project33
//
//  Created by Alex 6.1 on 9/29/21.
//

import UIKit

class SelectGenreViewController: UITableViewController {
    
    static var genres = ["Dance","R&B","Pop","Hip Hop","Unknown"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select Genre"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Genre", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
