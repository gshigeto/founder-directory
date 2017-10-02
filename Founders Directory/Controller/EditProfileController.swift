//
//  EditProfileController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/29/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class EditProfileController : UITableViewController {
    
    // Mark: - Constants
    private struct Storyboard {
        static let ShowProfileSegueIdentifier = "ShowProfile"
    }
    
    // Mark: - Properties
    var founder: Founder!
    let imagePicker = UIImagePickerController()
    var emailListed: Bool = true
    var phoneListed: Bool = true
    
    // Mark: - Outlets
    @IBOutlet weak var founderPhoto: UIImageView!
    @IBOutlet weak var founderName: UITextField!
    @IBOutlet weak var founderCompany: UITextField!
    @IBOutlet weak var founderPhone: UITextField!
    @IBOutlet weak var founderPhoneListed: UISwitch!
    @IBOutlet weak var founderEmail: UITextField!
    @IBOutlet weak var founderEmailListed: UISwitch!
    @IBOutlet weak var founderSpouse: UITextField!
    @IBOutlet weak var founderBusinessProfile: UITextView!
    
    // Mark: - Actions
    @IBAction func listEmail(_ sender: UISwitch) {
        emailListed = sender.isOn
    }
    
    @IBAction func listPhone(_ sender: UISwitch) {
        phoneListed = sender.isOn
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        saveProfile()
        FounderDeck.sharedInstance.saveFounders()
        performSegue(withIdentifier: Storyboard.ShowProfileSegueIdentifier, sender: self)
    }
    
    @IBAction func updatePhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
//        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Mark: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        founderPhoto.applyCircleMask()
        founderPhoto.applyBorder()
        fillProfile()
    }
    
    // Mark: - Private Helpers
    private func fillProfile() {
        founderName.text = founder.name
        founderCompany.text = founder.company_name
        founderPhone.text = founder.phone
        founderPhoneListed.isOn = founder.phone_listed
        founderEmail.text = founder.email
        founderEmailListed.isOn = founder.email_listed
        founderSpouse.text = founder.spouse_name
        founderBusinessProfile.text = founder.business_profile
        
        founderPhoto.image = UIImage(named: String(founder.photo))
    }
    
    private func saveProfile() {
        founder.name = founderName.text!
        founder.company_name = founderCompany.text!
        founder.phone = founderPhone.text!
        founder.phone_listed = founderPhoneListed.isOn
        founder.email = founderEmail.text!
        founder.email_listed = founderEmailListed.isOn
        founder.spouse_name = founderSpouse.text!
        founder.business_profile = founderBusinessProfile.text!
    }
    
}
