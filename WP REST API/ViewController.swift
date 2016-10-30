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
    
    //JSON
    let latestPosts : String = "https://www.winandmac.com/wp-json/wp/v2/posts/"
    
    let para : [String:AnyObject] = [
        "filter[category_name]" : "news" as AnyObject,
        "filter[posts_per_page]" : 10 as AnyObject
    ]
    
    var json : JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        getPosts(getposts: latestPosts)
    }
    
    func getPosts(getposts : String)
    {
        
        Alamofire.request(getposts, method: .get, parameters: para, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
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
        guard let title = self.json[0]["title"]["rendered"].string else{
            cell.textLabel?.text = "Loading..."
            return cell
        }
        cell.textLabel?.text = title
        return cell
    }


}

