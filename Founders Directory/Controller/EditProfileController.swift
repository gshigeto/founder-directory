//
//  EditProfileController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/29/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class EditProfileController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Mark: - Constants
    private struct ActionSheet {
        static let title = "Select Image From"
        static let camera = "Camera"
        static let library = "Library"
        static let cancel = "Cancel"
    }
    
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
        FounderDeck.sharedInstance.buildLetterDictionary()
        performSegue(withIdentifier: Storyboard.ShowProfileSegueIdentifier, sender: self)
    }
    
    @IBAction func updatePhoto(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: ActionSheet.title, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: ActionSheet.camera, style: .default, handler: {
            (action: UIAlertAction) -> Void in
            self.choosePhoto(UIImagePickerControllerSourceType.camera)
        }))
        actionSheet.addAction(UIAlertAction(title: ActionSheet.library, style: .default, handler: {
            (action: UIAlertAction) -> Void in
            self.choosePhoto(UIImagePickerControllerSourceType.photoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: ActionSheet.cancel, style: .cancel , handler: {
            (action: UIAlertAction) -> Void in
            actionSheet.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // Mark: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        founderPhoto.applyCircleMask()
        founderPhoto.applyBorder()
        fillProfile()
    }
    
    // Mark: - Image Picker Delegate Lifecycle
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            founderPhoto.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
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
    
    private func choosePhoto(_ location: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = location
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
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
