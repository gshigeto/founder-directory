//
//  ProfileController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit
import Foundation

class ProfileController : UITableViewController {
    
    // Mark: - Constants
    private struct HelpText {
        static let no_phone = "No phone listed"
        static let no_email = "No email listed"
        static let no_spouse = "No spouse listed"
        static let no_business_profile = "No business profile"
    }
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        style()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fillProfile()
    }
    
    // Mark: - Private Helpers
    private func fillProfile() {
        if let decodedData = Data(base64Encoded: founder.photo, options: .ignoreUnknownCharacters) {
            profileImage.image = UIImage(data: decodedData)
        } else {
            profileImage.image = UIImage(named: String(founder.photo))
        }
        founderName.text = founder.name
        founderCompany.text = founder.company_name
        if !founder.phone_listed || founder.phone == "" {
            founderPhone.textLabel?.text = HelpText.no_phone
            textButton.isEnabled = false
            callButton.isEnabled = false
        } else {
            founderPhone.textLabel?.text = founder.phone
        }
        if !founder.email_listed || founder.email == "" {
            founderEmail.textLabel?.text = HelpText.no_email
            emailButton.isEnabled = false
        } else {
            founderEmail.textLabel?.text = founder.email
        }
        founderSpouseName.textLabel?.text = founder.spouse_name == "" ? HelpText.no_spouse : founder.spouse_name
        founderBusinessProfile.textLabel?.text = founder.business_profile == "" ? HelpText.no_business_profile : founder.business_profile
        if !founder.editable {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func performAction(url: URL) {
        let shared = UIApplication.shared
        if shared.canOpenURL(url) {
            shared.open(url, options: [:]) {(_) in return}
        } else {
            print("Unable to send message")
        }
    }
    
    private func style() {
        profileImage.applyCircleMask()
        profileImage.applyBorder()
        textButton.applyCircle()
        callButton.applyCircle()
        emailButton.applyCircle()
    }
    
    // Mark: - Segue
    @IBAction func showProfile(_ segue: UIStoryboardSegue) {
        fillProfile()
    }
    
}
