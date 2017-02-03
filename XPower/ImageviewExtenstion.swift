//
//  ImageviewExtenstion.swift
//  XPower
//
//  Created by Software Merchant on 2/2/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Properties
extension UIImageView {

    //load image async from inaternet
    func loadFromFile(photo:String){
        let img = UIImage(named: photo)
        self.image = img
        self.alpha = 0.4
    }
}
