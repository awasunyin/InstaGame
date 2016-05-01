//
//  PostTableViewCell.swift
//  InstaGame
//
//  Created by Haohua Sun Yin on 24/3/16.
//  Copyright © 2016 Awa Sun Yin. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    
    @IBOutlet weak var addedBy: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
