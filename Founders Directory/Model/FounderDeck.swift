//
//  FounderDeck.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import Foundation

class FounderDeck {
    
    // Mark: - Constants
    private enum Defaults: String {
        case founders
    }
    
    // Mark: - Properties
    var founders: [Founder] = []
    var foundersDictionary = [String: [Founder]]()
    var letters = [String]()
    
    // Mark: - Singleton Pattern
    static let sharedInstance = FounderDeck()
    private init() {
        loadFounders()
    }
    
    // Mark: - Public Helpers
    public func saveFounders() {
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: founders)
        defaults.set(encodedData, forKey: Defaults.founders.rawValue)
        defaults.synchronize()
        buildLetterDictionary()
    }

    // Mark: - Private Helpers
    private func buildLetterDictionary() {
        sortFounders()
        foundersDictionary.removeAll()
        letters = []
        for founder in founders {
            var arr = founder.name.split{$0 == " "}
            let last_name = arr[arr.count - 1]
            
            let letter = String(last_name[last_name.startIndex])
            if foundersDictionary[letter] == nil {
                foundersDictionary[letter] = [founder]
                letters.append(letter)
            } else {
                foundersDictionary[letter]!.append(founder)
            }
        }
    }
    
    private func loadFounders() {
        let defaults = UserDefaults.standard
        
        if let savedFounders = defaults.data(forKey: Defaults.founders.rawValue),
            let foundersList = NSKeyedUnarchiver.unarchiveObject(with: savedFounders) as? [Founder] {
            founders = foundersList
        } else {
            preBuiltFounders()
        }
        buildLetterDictionary()
    }
    
    private func preBuiltFounders() {
        founders = [
            Founder(name: "Bill Gates", company_name: "Microsoft", phone: "801-555-1212", email: "bill@gmail.com", spouse_name: "Melinda Gates", business_profile: "Gates has held the No. 1 spot as the world's richest person for four years in a row, and for 18 out of the past 23 years.", photo: "bill.png"),
            
            Founder(name: "Warren Buffett", company_name: "Berkshire Hathaway", phone: "801-555-1212", email: "warren@gmail.com", business_profile: "Warren Edward Buffett is an American business magnate, investor, and philanthropist. Buffett serves as the Chief Executive Officer and Chairman of Berkshire Hathaway.", photo: "warren.png"),
            
            Founder(name: "Jeff Bezos", company_name: "Amazon", phone: "801-555-1212", email: "jeff@gmail.com", spouse_name: "MacKenzie Bezos", business_profile: "Jeffrey Preston Bezos is an American technology and retail entrepreneur, investor, computer scientist, and philanthropist, best known as the founder, chairman, and chief executive officer of Amazon.com, the world's largest online shopping retailer.", photo: "jeff.png"),
            
            Founder(name: "Amancio Ortega", company_name: "Zara", phone: "801-555-1212", email: "amancio@gmail.com", business_profile: "Amancio Ortega Gaona is a Spanish business tycoon. He is the founder and former chairman of Inditex fashion group, best known for its chain of Zara clothing and accessories retail shops. Amancio is the wealthiest retailer in the world.", photo: "amancio.png"),
            
            Founder(name: "Mark Zuckerberg", company_name: "Facebook", phone: "801-555-1212", email: "mark@gmail.com", spouse_name: "Priscilla Chan", business_profile: "Mark Elliot Zuckerberg is an American computer programmer and Internet entrepreneur. He is a co-founder of Facebook, and currently operates as its chairman and chief executive officer.", photo: "mark.png"),
            
            Founder(name: "Carlos Slim Helu", company_name: "América Móvil", phone: "801-555-1212", email: "carlos@gmail.com", business_profile: "Carlos Slim Helú is a Mexican business magnate, investor, and philanthropist. From 2010 to 2013, Slim was ranked as the richest person in the world.", photo: "carlos.png"),
            
            Founder(name: "Gavin Nitta", company_name: "No Company Yet", phone: "702-526-3926", email: "gshigeto@gmail.com", spouse_name: "Kelli Nitta", business_profile: "Software Engineer at Blip Billboards", photo: "myself", editable: true)
        ]
    }
    
    private func sortFounders() {
        founders.sort{
            var arr1 = $0.name.split{$0 == " "}
            let lastName1 = arr1[arr1.count - 1]
            
            var arr2 = $1.name.split{$0 == " "}
            let lastName2 = arr2[arr2.count - 1]
            
            return lastName1 < lastName2
        }
    }
}
