//
//  FounderModel.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import Foundation

class Founder : NSObject, NSCoding {
    
    // Mark: - Constants
    private struct Founder {
        static let name = "name"
        static let company_name = "company_name"
        static let phone = "phone"
        static let phone_listed = "phone_listed"
        static let email = "email"
        static let email_listed = "email_listed"
        static let spouse_name = "spouse_name"
        static let business_profile = "business_profile"
        static let photo = "photo"
        static let editable = "editable"
    }
    
    // Mark: - Properties
    var name: String
    var company_name: String
    var phone: String
    var phone_listed: Bool
    var email: String
    var email_listed: Bool
    var spouse_name: String
    var business_profile: String
    var photo: String
    var editable: Bool
    
    // Mark: - Initialization
    override init() {
        self.name = ""
        self.company_name = ""
        self.phone = ""
        self.phone_listed = true
        self.email = ""
        self.email_listed = true
        self.spouse_name = ""
        self.business_profile = ""
        self.photo = ""
        self.editable = false
    }
    
    init(name: String, company_name: String, phone: String, phone_listed: Bool = true, email: String, email_listed: Bool = true,
         spouse_name: String = "", business_profile: String = "", photo: String, editable: Bool = false) {
        self.name = name
        self.company_name = company_name
        self.phone = phone
        self.phone_listed = phone_listed
        self.email = email
        self.email_listed = email_listed
        self.spouse_name = spouse_name
        self.business_profile = business_profile
        self.photo = photo
        self.editable = editable
    }
    
    // Mark: - Decoder
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: Founder.name) as? String ?? ""
        self.company_name = decoder.decodeObject(forKey: Founder.company_name) as? String ?? ""
        self.phone = decoder.decodeObject(forKey: Founder.phone) as? String ?? ""
        self.phone_listed = decoder.decodeBool(forKey: Founder.phone_listed)
        self.email = decoder.decodeObject(forKey: Founder.email) as? String ?? ""
        self.email_listed = decoder.decodeBool(forKey: Founder.email_listed)
        self.spouse_name = decoder.decodeObject(forKey: Founder.spouse_name) as? String ?? ""
        self.business_profile = decoder.decodeObject(forKey: Founder.business_profile) as? String ?? ""
        self.photo = decoder.decodeObject(forKey: Founder.photo) as? String ?? ""
        self.editable = decoder.decodeBool(forKey: Founder.editable)
    }
    
    // Mark: - Encoder
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Founder.name)
        coder.encode(company_name, forKey: Founder.company_name)
        coder.encode(phone, forKey: Founder.phone)
        coder.encode(phone_listed, forKey: Founder.phone_listed)
        coder.encode(email, forKey: Founder.email)
        coder.encode(email_listed, forKey: Founder.email_listed)
        coder.encode(spouse_name, forKey: Founder.spouse_name)
        coder.encode(business_profile, forKey: Founder.business_profile)
        coder.encode(photo, forKey: Founder.photo)
        coder.encode(editable, forKey: Founder.editable)
    }
}
