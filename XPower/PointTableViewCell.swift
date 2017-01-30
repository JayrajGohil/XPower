//
//  PointTableViewCell.swift
//  XPower
//
//  Created by Software Merchant on 1/30/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

class PointTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAddBtn(_ sender: Any) {
    }
}
