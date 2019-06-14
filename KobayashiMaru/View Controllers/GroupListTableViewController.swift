//
//  GroupListTableViewController.swift
//  KobayashiMaru
//
//  Created by Dustin Koch on 6/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class GroupListTableViewController: UITableViewController {
    

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Actions
    @IBAction func addPersonButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func shuffleButtonTapped(_ sender: UIBarButtonItem) {
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Helper functions
    func updateView() {
        
    }

}//END OF VIEW CONTROLLER

extension GroupListTableViewController {
    func presentSimpleInputAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let postAction = UIAlertAction(title: "Add Contact", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text,
                !name.isEmpty else { return }
            GroupController.sharedInstance.addPerson(name: name)
            self.updateView()
        }
        alertController.addAction(dismissAction)
        alertController.addAction(postAction)
        self.present(alertController, animated: true)
    }
}//END OF EXTENSION
