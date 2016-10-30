//
//  ViewController.swift
//  WP REST API
//
//  Created by Peter Leung on 30/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var currentNoOfItems = 10
    //JSON
    var latestPosts : String = "https://www.winandmac.com/wp-json/wp/v2/posts/?filter[category_name]=news&per_page="
    
//    let para : [String:AnyObject] = [
//        "filter[category_name]" : "news" as AnyObject,
//        "&per_page" : 100 as AnyObject,
//    ]
    
    var json : JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        latestPosts = "https://www.winandmac.com/wp-json/wp/v2/posts/?filter[category_name]=news&per_page=\(currentNoOfItems)"
        getPosts(getposts: latestPosts)
    }
    
    func getPosts(getposts : String)
    {
        
        Alamofire.request(getposts, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            guard let data = response.result.value else{
                print("Request failed with error")
                return
            }
            
            self.json = JSON(data)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of items \(self.json.count)")
        switch self.json.type
        {
        case Type.array:
            return self.json.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        //Make sure post title is a string
        guard let title = self.json[indexPath.row]["title"]["rendered"].string else{
            cell.textLabel?.text = "Loading..."
            return cell
        }
        cell.textLabel?.text = title
        let lastElementFound = self.json.count - 1
        if indexPath.row == lastElementFound, currentNoOfItems < 100 {
            // handle your logic here to get more items, add it to dataSource and reload tableview
            print("scrolled to bottom")
            currentNoOfItems += 10
            latestPosts = "https://www.winandmac.com/wp-json/wp/v2/posts/?filter[category_name]=news&per_page=\(currentNoOfItems)"
            getPosts(getposts: latestPosts)
        }
        return cell
    }


}

