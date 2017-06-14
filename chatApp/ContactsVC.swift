//
//  ContactsVC.swift
//  chatApp
//
//  Created by akash savediya on 01/05/17.
//  Copyright © 2017 akash savediya. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController, UITabBarDelegate, UITableViewDataSource, FetchData {
    
    @IBOutlet weak var myTable: UITableView!
    
    private let CELL_ID = "cell"
    private let CHAT_SEGUE = "ChatSegue"
    
    private var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBProvider.Instance.delegate = self
        DBProvider.Instance.getContacts()

    }
    
    func dataReceived(contacts: [Contact]) {
        self.contacts = contacts
        
        
        //get the name of current user
        for contact in contacts {
            if contact.id == AuthProvider.Instance.userID() {
                AuthProvider.Instance.userName = contact.name
            }
        }
        
        myTable.reloadData()
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGUE, sender: nil)
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil);
        }
    }


}