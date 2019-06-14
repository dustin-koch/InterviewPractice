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
        presentSimpleInputAlert(title: "Let's Make Groups!", message: "Enter name, below...")
    }
    @IBAction func shuffleButtonTapped(_ sender: UIBarButtonItem) {
        GroupController.sharedInstance.shufflePeople()
        GroupController.sharedInstance.updateGroups()
        print(GroupController.sharedInstance.masterPersonList)
        updateView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return GroupController.sharedInstance.groups.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupController.sharedInstance.groups[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = GroupController.sharedInstance.groups[indexPath.section][indexPath.row]
        cell.textLabel?.text = person
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = GroupController.sharedInstance.groups[indexPath.section][indexPath.row]
            GroupController.sharedInstance.deletePerson(name: person)
            updateView()
            // Delete the row from the data source (throwing error?! so reloaded table view instead)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Helper functions
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}//END OF VIEW CONTROLLER

extension GroupListTableViewController {
    func presentSimpleInputAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let postAction = UIAlertAction(title: "Add Person", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text,
                !name.isEmpty else { return }
            GroupController.sharedInstance.addPerson(name: name)
            self.updateView()
            print(GroupController.sharedInstance.masterPersonList)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(postAction)
        self.present(alertController, animated: true)
    }
}//END OF EXTENSION
