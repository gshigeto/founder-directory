//
//  Helper.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 10/2/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

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

extension UIButton {
    func applyCircle() {
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
    }
}

extension UIImage {
    public func base64() -> String? {
        var imageData: Data?
        imageData = UIImagePNGRepresentation(self)
        return imageData?.base64EncodedString()
    }
}
