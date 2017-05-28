//
//  SearchCell.swift
//  Emogif
//
//  Created by hintoro on 5/27/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: UITableViewCell {

    @IBOutlet weak var imv: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imv.layer.cornerRadius = (self.imv.frame.size.width)  / 2
        self.imv.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
