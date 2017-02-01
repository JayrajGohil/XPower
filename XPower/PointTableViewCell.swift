//
//  PointTableViewCell.swift
//  XPower
//
//  Created by Software Merchant on 1/30/17.
//  Copyright © 2017 Instock. All rights reserved.
//

import UIKit

protocol PointTableCellDelegate {
    func pointDeedAdded(at: Int)
}

class PointTableViewCell: UITableViewCell {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraint_BtnWidth: NSLayoutConstraint!
    
    var delegate:PointTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAddBtn(_ sender: Any) {
        delegate?.pointDeedAdded(at: self.tag)
    }
}
