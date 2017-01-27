//
//  LeftMenuHeaderView.swift
//  XPower
//
//  Created by Software Merchant on 1/27/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class LeftMenuHeaderView: UITableViewCell {

    @IBOutlet weak var imgvAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
