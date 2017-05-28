//
//  SuggestCell.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import SDWebImage
class SuggestCell: UITableViewCell {

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feed:[Feed]?
    {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var delegate:DetailVCDelegate? = nil
    
    var iClosure: ((_ id:Int, _ width:Int,_ height:Int) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView._registerNibs(nibName: "HomeCell",identifier:"HomeCell")
        setupCollectionView()
        _requestSuggest { (response) in
            self.feed = response?.data
            log.debug(self.feed?.count)
        }
        let detailVC = DetailVC()
        self.delegate = detailVC
        self.delegate?.xinchao()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension SuggestCell
{
    func setupCollectionView(){
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        
        // Collection view attributes
        self.collectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.collectionView.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isScrollEnabled = false
        
    }

}
extension SuggestCell: CHTCollectionViewDelegateWaterfallLayout
{
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        guard let item = feed?[indexPath.row] else {
            return CGSize.zero
        }
        if item.type != "ads"
        {
            let cellHeight:CGFloat = CGFloat(item.height_thumb_gif + 70)
            let imageSize:CGSize = CGSize(width: SCREEN_WIDTH / 2, height: cellHeight)
            return imageSize
        }
        else{
            return CGSize.zero
        }
    }

}
extension SuggestCell: UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let item = feed?.count
        {
            return item
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        guard let item = feed?[indexPath.row] else {
            return cell
        }
        if item.type != "ads"
        {
            cell.imv.setShowActivityIndicator(true)
            cell.imv.setIndicatorStyle(.gray)
            cell.imv.sd_setImage(with: URL(string: item.thumb_gif))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCell
        {
             self._sd_clear()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = feed?[indexPath.row] else {
            return
        }
        print(item.post_id)
        print(item.width_thumb_gif)
        print(item.height_thumb_gif)
        self.iClosure!(item.post_id, item.width_thumb_gif, item.height_thumb_gif)
    }

}
