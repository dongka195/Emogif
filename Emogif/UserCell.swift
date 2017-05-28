//
//  UserCell.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import SDWebImage
class UserCell: UITableViewCell {

    @IBOutlet weak var userIMV: UIImageView!
    @IBOutlet weak var userLB: UILabel!
    @IBOutlet weak var reportBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userIMV.layer.cornerRadius = (userIMV.frame.size.width) / 2
        self.userIMV.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
