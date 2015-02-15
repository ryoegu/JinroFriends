//
//  RolePurchaseTableViewCell.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/06.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class RolePurchaseTableViewCell: UITableViewCell {

    @IBOutlet var roleLabel: UILabel!
    @IBOutlet var purchaseButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
