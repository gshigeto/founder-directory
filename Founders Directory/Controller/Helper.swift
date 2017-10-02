//
//  Helper.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 10/2/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class Helper {
    static func applyRoundBorder(to imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.masksToBounds = true
    }
}

extension UIImageView {
    func applyCircleMask() {
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
    
    func applyBorder() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
    }
}
