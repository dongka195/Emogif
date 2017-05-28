//
//  HomeVC.swift
//  Emogif
//
//  Created by hintoro on 5/23/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import Alamofire
import MagicMapper
import Gifu
import XCGLogger
import SDWebImage
import SwiftyGif
class HomeVC: BaseVC{
    
    var feed:[Feed]?
    {
        didSet{
            self.collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        registerNibs()
        setupCollectionView()
        _requestFeedHome { (response) in
            self.feed = response?.data
            log.debug(self.feed?.count)
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
//        self._sd_clear()
    }
    override func didReceiveMemoryWarning() {
        self._sd_clear()
        self.collectionView.reloadData()

    }
}
extension HomeVC
{
    //MARK: - CollectionView UI Setup
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
        
        self.collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
    }
    
    func registerNibs(){
        let viewNib = UINib(nibName: "HomeCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: "HomeCell")
    }
}
extension HomeVC: CHTCollectionViewDelegateWaterfallLayout
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

extension HomeVC :UICollectionViewDelegate,UICollectionViewDataSource
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
//            cell.imv.sd_cancelCurrentAnimationImagesLoad()
//            cell.imv.animationImages = nil
//            cell.imv.image = nil
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self._redirect(stName: "Detail",vcName: "DetailVC") as! DetailVC
        guard let id = feed?[indexPath.row].post_id else {
            return
        }
        guard let item = feed?[indexPath.row] else {
            return
        }
        vc.postId = id
        vc.imageWidth = CGFloat(item.width_thumb_gif)
        vc.imageHeight = CGFloat(item.height_thumb_gif)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

