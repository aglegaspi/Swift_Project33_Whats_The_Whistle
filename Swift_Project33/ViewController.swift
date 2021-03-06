//
//  ViewController.swift
//  Swift_Project33
//
//  Created by Alex 6.1 on 9/28/21.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {
    
    var whistles = [Whistle]()
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "What's that Whistle?"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(selectGenre))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        //register the cell reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if ViewController.isDirty {
            loadWhistles()
        }
    }
    
    
    //MARK: - FUNCTIONS
    func loadWhistles() {
        // describes a filter
        let pred = NSPredicate(value: true)
        
        // which field we want to sort on, whether we want it ascending/desending
        let sort = NSSortDescriptor(key: "date", ascending: false)
        
        // combines predicatee and sort descripter with the name of record type we want to query
        let query = CKQuery(recordType: "Whistles", predicate: pred)
        query.sortDescriptors = [sort]
        
        // executes a query and returning results
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["genre", "comments"]
        operation.resultsLimit = 50
        
        var newWhistles = [Whistle]()
        
        // convert each record into a Whistle object get the ID, genre, and comments.
        // then append to the newWhistles array
        operation.recordFetchedBlock = { record in
            let whistle = Whistle()
            whistle.recordID = record.recordID
            whistle.genre = record["genre"]
            whistle.comments = record["comments"]
            newWhistles.append(whistle)
        }
        
        // on success the whistles array will be updated with new whistles and reload the table view
        // on fail the user will be prompted with an alert
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    ViewController.isDirty = false
                    self.whistles = newWhistles
                    self.tableView.reloadData()
                } else {
                    let ac = UIAlertController(title: "Fetch Failed.", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    print(error!.localizedDescription)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
            
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
        
        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }
        return titleString
    }
    
    func genreCellColor(genre: String) -> UIColor {
        
        switch genre {
        case "Dance": return .systemRed
        case "Pop": return .systemBlue
        case "R&B": return .systemPink
        case "Hip Hop": return .systemGreen
            
        default:
            return .systemGray2
        }
    }
    
    //MARK: - OBJ-C FUNCTIONS
    @objc func addWhistle() {
        let vc = RecordWhistleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectGenre() {
        let vc = MyGenresViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - TABLEVIEW
    // use dynamic type to ensure user font choices and set number of lines to unlimited
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.attributedText = makeAttributedString(title: whistles[indexPath.row].genre, subtitle: whistles[indexPath.row].comments)
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = genreCellColor(genre: whistles[indexPath.row].genre)
        return cell
    }
    
    // tell iOS how many rows we need
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.whistles.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultsViewController()
        vc.whistle = whistles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CKContainer.default().publicCloudDatabase.delete(withRecordID: whistles[indexPath.row].recordID) { _, error in
                if error == nil {
                    print("successfully deleted whistle")
                    DispatchQueue.main.async {
                        self.whistles.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .top)
                        tableView.reloadData()
                    }
                    
                } else {
                    print(error!.localizedDescription)
                }
            }
            
        }
    }

}

