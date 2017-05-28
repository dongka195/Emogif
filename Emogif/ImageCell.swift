//
//  HeaderCell.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import  Gifu
import Spring
import SDWebImage


class ImageCell: UITableViewCell{

    @IBOutlet weak var likeBtn: SpringButton!
    @IBOutlet weak var commentBtn: SpringButton!
    @IBOutlet weak var shareBtn: SpringButton!
    @IBOutlet weak var bookmarkBtn: SpringButton!
    @IBOutlet weak var imv: GIFImageView!
    
    var isLike:Int = 0
    var isBookmark = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeAction(_ sender: Any) {
        self.likeBtn.animation = "pop"
        self.likeBtn.animateTo()
        if isLike == 1
        {
            log.debug("The user dislike this post .....")
            likeBtn.setImage(UIImage(named: "favoriteNomal"),for: .normal)
            isLike = 0
        }
        else
        {
            log.debug("The user like this post .....")
            likeBtn.setImage(UIImage(named: "favorite"), for: .normal)
            isLike = 1
        }
        
        
    }
    @IBAction func commentAction(_ sender: Any) {
    }
    @IBAction func shareAction(_ sender: Any) {
    }
    @IBAction func bookmarkAction(_ sender: Any) {
       
        if isBookmark == 1
        {
            log.debug("The user unbookmark this post .....")
            bookmarkBtn.setImage(UIImage(named: "bookmark-white"),for: .normal)
            isBookmark = 0
        }
        else
        {
            log.debug("The user bookmark this post .....")
            bookmarkBtn.setImage(UIImage(named: "bookmark-ribbon"), for: .normal)
            isBookmark = 1
        }
    }
    
}
