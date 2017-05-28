//
//  HomeCell.swift
//  Emogif
//
//  Created by hintoro on 5/24/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import Gifu
class HomeCell: UICollectionViewCell {

    @IBOutlet weak var imv: GIFImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var numLike: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
