//
//  SeatsCollectionViewCell.swift
//  JinroHelper
//
//  Created by Ryo Eguchi on 2015/02/16.
//  Copyright (c) 2015年 Ryo Eguchi. All rights reserved.
//

import UIKit

class SeatsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 30.0
        //self.contentView.layer.borderWidth = 1.0
        //self.contentView.layer.borderColor = UIColor.whiteColor().CGColor
        self.contentView.backgroundColor = UIColor.yellowColor()
    }
    

}
