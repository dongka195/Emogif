//
//  DetailVC.swift
//  Emogif
//
//  Created by hintoro on 5/25/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import MagicMapper
import Alamofire
import Gifu
import XCGLogger
import SDWebImage.SDImageCache

protocol DetailVCDelegate {
    func xinchao() -> Void
    func pushViewController(id:Int) -> Void
}

class DetailVC: BaseVC,DetailVCDelegate {
    
    var imageHeight:CGFloat?
    var imageWidth:CGFloat?
    var postId:Int?
    var post:Post?{
        didSet{
            self.tableView.reloadData()
        }
    }
    var commentArray:CommentSearch?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
//        super.viewDidLoad()
        self.tableView._registerNibs(nibName: "UserCell", identifier: "UserCell")
        self.tableView._registerNibs(nibName: "ImageCell", identifier: "ImageCell")
        self.tableView._registerNibs(nibName: "CommentCell", identifier: "CommentCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadData()
        self.loadComment()
    }
    
    override func didReceiveMemoryWarning() {
        self._sd_clear()
        log.warning("Cảnh báo memory")
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
        log.debug("Chạy vào thằng này!")
        var nav = self.navigationController?.viewControllers
        
        nav?.removeAll()
        self.navigationController?.viewControllers = nav!
        self._sd_clear()
    }
    
    //MARK:- SERVICES
    
    func loadData()
    {
        Alamofire.request(API_DETAIL,method: .post,parameters: ["token":DEFAULT_TOKEN,"post_id":postId!,"uuid":UUID]).responseJSON { (response) in
            if let dictionary = response.result.value as? KeyValue {
                self.post = PostSearch(dictionary).data
            }
        }
    }
    func loadComment()
    {
        
        log.debug("Post id  = \(String(describing: self.postId))")
        Alamofire.request(API_GETPOSTCOMMENT,method: .post,parameters: ["token":DEFAULT_TOKEN,"post_id":postId!,"uuid":UUID]).responseJSON { (response) in
            if let dictionary = response.result.value as? KeyValue {
                self.commentArray = CommentSearch(dictionary)
            }
        }
        
    }
    
    //Delegate
    func pushViewController(id:Int) {
        let vc = DetailVC()
        vc.postId = id
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func xinchao() {
        print("ABC")
    }
    

}


extension DetailVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = self.commentArray?.data else {
            return 0
        }
        switch item.count
        {
        case 0:
            return 3
        case 1:
            return 4
        default:
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
            guard let item = self.post else {
                return cell
            }
            cell.userIMV.setShowActivityIndicator(true)
            cell.userIMV.setIndicatorStyle(.gray)
            cell.userIMV.sd_setImage(with: URL(string:(item.author?.avatar)!))
            cell.userLB.text = item.author?.name
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            guard let item = self.post else {
                return cell
            }
            cell.imv.setShowActivityIndicator(true)
            cell.imv.setIndicatorStyle(.gray)
            cell.imv.sd_setImage(with: URL(string: item.image))
            cell.selectionStyle = .none
            cell.isLike = item.isLike
            cell.isBookmark = item.isBookmark
            (item.isLike == 1) ? cell.likeBtn.setImage(UIImage(named: "favorite"), for: .normal): cell.likeBtn.setImage(UIImage(named: "favoriteNomal"), for: .normal)
            (item.isBookmark == 1) ? cell.bookmarkBtn.setImage(UIImage(named: "bookmark-ribbon"), for: .normal): cell.bookmarkBtn.setImage(UIImage(named: "bookmark-white"), for: .normal)
            cell.selectionStyle = .none
            
            return cell
        }else if indexPath.row == self.tableView.numberOfRows(inSection: 0) - 1
        {
            //Phan cho suggest
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestCell", for: indexPath) as! SuggestCell
            cell.backgroundColor = UIColor.red
            cell.selectionStyle = .none
            cell.iClosure = {
                s , w, h in
                let storyboard = UIStoryboard(name: "Detail", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                vc.postId = s
                vc.imageWidth = CGFloat(w)
                vc.imageHeight = CGFloat(h)
                self.post = nil
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            return cell
        }else{
            //Comment  khoong xac dinh
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            guard let item = commentArray?.data else {
                return cell
            }
            
            if indexPath.row == 2
            {
                cell.username.text = (item[item.count - 1].author?.name)! + " :"
                cell.comment.text = item[item.count - 1].content
            }
            else
            {
                cell.username.text = (item[item.count - 2].author?.name)! + " :"
                cell.comment.text = item[item.count - 2].content
            }
           
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ImageCell
        {
            log.debug("EndDislay image cell ...........")
            cell.imv.sd_cancelCurrentAnimationImagesLoad()
            cell.imv.animationImages = nil
            cell.imv.image = nil
            
            self._sd_clear()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = self.commentArray?.data else
        {
            return 0
        }
        if item.count == 0
        {
            if indexPath.row == 1
            {
                return (SCREEN_WIDTH * self.imageHeight!) / self.imageWidth!
            }
            else if indexPath.row == 2{
                return 1500
            }else if indexPath.row == 0
            {
                return 50
            }
            else
            {
                return 50
            }
        }
        else if item.count == 1
        {
            if indexPath.row == 1
            {
                return (SCREEN_WIDTH * self.imageHeight!) / self.imageWidth!
            }
            else if indexPath.row == 3{
                return 1500
            }
            else if indexPath.row == 0
            {
                return 50
            }
            else
            {
                return 50
            }
        }
        else{
            if indexPath.row == 1
            {
                return (SCREEN_WIDTH * self.imageHeight!) / self.imageWidth!
            }
            else if indexPath.row == 4{
                return 1500
            }
            else if indexPath.row == 0
            {
                return 50
            }
            else
            {
                return UITableViewAutomaticDimension
            }
            
        }
    }
}
