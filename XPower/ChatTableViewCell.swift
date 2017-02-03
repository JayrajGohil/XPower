//
//  ChatTableViewCell.swift
//  XPower
//
//  Created by Software Merchant on 2/2/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var constraint_lblTitle_Leading: NSLayoutConstraint!
    @IBOutlet weak var constraint_lblTitle_Trailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
