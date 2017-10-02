//
//  FoundersDirectoryController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class FoundersDirectoryController : UITableViewController {
    
    // Mark: - Constants
    private struct StoryBoard {
        static let FounderCellIdentifier = "FounderCell"
        static let ShowProfileSegueIdentifier = "ShowProfile"
    }
    
    // Mark: - Properties
    var selectedFounder: Founder?
    
    // Mark: - View Controller Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RotatingNavigationController {
            if let profileVC = destinationVC.childViewControllers[0] as? ProfileController {
                profileVC.founder = selectedFounder
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }
    
    // Mark: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return FounderDeck.sharedInstance.foundersDictionary.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return FounderDeck.sharedInstance.letters
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.FounderCellIdentifier, for: indexPath)
        
        let instance = FounderDeck.sharedInstance
        let founder = instance.foundersDictionary[instance.letters[indexPath.section]]![indexPath.row]
        
        cell.textLabel?.text = founder.name.capitalized
        cell.detailTextLabel?.text = founder.company_name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let instance = FounderDeck.sharedInstance
        return instance.foundersDictionary[instance.letters[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FounderDeck.sharedInstance.letters[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instance = FounderDeck.sharedInstance
        selectedFounder = instance.foundersDictionary[instance.letters[indexPath.section]]![indexPath.row]
        performSegue(withIdentifier: StoryBoard.ShowProfileSegueIdentifier, sender: self)
    }
    
    // Mark: - Segue
    @IBAction func showDirectory(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
}
