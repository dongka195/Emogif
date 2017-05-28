//
//  SearchVC.swift
//  Emogif
//
//  Created by hintoro on 5/23/17.
//  Copyright © 2017 Hintoro. All rights reserved.
//

import UIKit
import Alamofire
import MagicMapper
import SDWebImage

class SearchVC: BaseVC{

    
    @IBOutlet weak var filterTableView: UITableView!
    let searchbar = UISearchBar()
    var channel:[Channel] = []
    {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var defaultChannel:[String] = ["Trending","Popular"]
    var filterArray:[Feed] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchBar()
        loadData()
        self.tableView._registerNibs(nibName: "SearchCell", identifier: "searchCell")
        self.filterTableView.isHidden = true
        self.filterTableView._registerNibs(nibName: "HomeCell", identifier: "HomeCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension SearchVC : UISearchBarDelegate
{
    func settingSearchBar()
    {
        searchbar.showsCancelButton = true
        searchbar.placeholder = "Find gif you like :p"
        searchbar.delegate = self
        self.navigationItem.titleView = searchbar
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        findAnyFeed(searchBar.text!)
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filterTableView.isHidden = true
        
    }
    func findAnyFeed(_ searchContent:String)
    {
        Alamofire.request(API_SEARCH,method: .post,parameters: ["token":"37ySKks6xEDy1","keyword":searchContent]).responseJSON { (response) in
            if let dictionary = response.result.value as? KeyValue {
                self.filterArray = FeedHome(dictionary).data
                log.debug("Number of filterArray have : = \(self.filterArray.count)")
                self.filterTableView.isHidden = false
            }
        }

    }
}




extension SearchVC
{
    func loadData()
    {
        Alamofire.request(API_GETALLCHANNEL,method: .post,parameters: ["token":DEFAULT_TOKEN,"page":1,"limit":10]).responseJSON { (response) in
            if let dictionary = response.result.value as? KeyValue {
                self.channel = ChannelSearch(dictionary).data
                log.debug("Number of channel have : = \(self.channel.count)")
            }
        }
    }

}

extension SearchVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 2
        }
        else
        {
            return self.channel.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        if indexPath.section == 1
        {
            let item = self.channel[indexPath.row]
            cell.imv.sd_setImage(with: URL(string: item.avatar))
            cell.title.text = item.name
            
        }
        else
        {
            cell.title.text = self.defaultChannel[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
