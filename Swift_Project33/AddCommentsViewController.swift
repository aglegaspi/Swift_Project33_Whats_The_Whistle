//
//  AddCommentsViewController.swift
//  Swift_Project33
//
//  Created by Alex 6.1 on 9/29/21.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    var genre = ""
    var comments: UITextView!
    var placeholder = "If you have any additional comments that might help identify your tine, enter them here."

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        comments = UITextView()
        comments.translatesAutoresizingMaskIntoConstraints = false
        comments.delegate = self
        comments.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(comments)
        
        comments.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comments.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        comments.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        comments.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }

}
