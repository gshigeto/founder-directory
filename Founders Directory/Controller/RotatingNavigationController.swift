//
//  RotatingNavigationController.swift
//  Founders Directory
//
//  Created by Gavin Nitta on 9/28/17.
//  Copyright © 2017 Gavin Nitta. All rights reserved.
//

import UIKit

class RotatingNavigationController : UINavigationController {
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
