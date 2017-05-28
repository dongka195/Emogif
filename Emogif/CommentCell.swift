//
//  CommentCell.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var comment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
