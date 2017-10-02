//
//  ProfileController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class ProfileController : UITableViewController {
    
    // Mark: - Properties
    var founder: Founder!
    
    // Mark: - Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var founderName: UILabel!
    @IBOutlet weak var founderCompany: UILabel!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var founderPhone: UITableViewCell!
    @IBOutlet weak var founderEmail: UITableViewCell!
    @IBOutlet weak var founderSpouseName: UITableViewCell!
    @IBOutlet weak var founderBusinessProfile: UITableViewCell!
    
    // Mark: - Actions
    @IBAction func call(_ sender: UIButton) {
        let tel = "tel:\(founder.phone)"
        let url = URL(string: tel)!
        performAction(url: url)
    }
    
    @IBAction func email(_ sender: UIButton) {
        let email = "mailto:\(founder.email)"
        let url = URL(string: email)!
        performAction(url: url)
    }
    
    @IBAction func textMessage(_ sender: UIButton) {
        let sms = "sms:\(founder.phone)"
        let url = URL(string: sms)!
        performAction(url: url)
    }
    
    // Mark: - View Controller Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editProfileVC = segue.destination as? EditProfileController {
            editProfileVC.founder = founder
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fillProfile()
        styleButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.applyCircleMask()
        profileImage.applyBorder()
    }
    
    // Mark: - Private Helpers
    private func fillProfile() {
        founderName.text = founder.name
        founderCompany.text = founder.company_name
        if !founder.phone_listed {
            // Hide the phone number
        }
        founderPhone.textLabel?.text = founder.phone
        if !founder.email_listed {
            // Hide the email
        }
        founderEmail.textLabel?.text = founder.email
        founderSpouseName.textLabel?.text = founder.spouse_name == "" ? "No Spouse Listed" : founder.spouse_name
        founderBusinessProfile.textLabel?.text = founder.business_profile
        
        profileImage.image = UIImage(named: String(founder.photo))
    }
    
    private func performAction(url: URL) {
        let shared = UIApplication.shared
        if shared.canOpenURL(url) {
            shared.open(url, options: [:]) {(_) in return}
        } else {
            print("Unable to send message")
        }
    }
    
    private func styleButtons() {
        textButton.layer.cornerRadius = textButton.bounds.size.width / 2
        textButton.clipsToBounds = true
        callButton.layer.cornerRadius = callButton.bounds.size.width / 2
        callButton.clipsToBounds = true
        emailButton.layer.cornerRadius = emailButton.bounds.size.width / 2
        emailButton.clipsToBounds = true
    }
    
    // Mark: - Segue
    @IBAction func showProfile(_ segue: UIStoryboardSegue) {
        fillProfile()
    }
    
}
