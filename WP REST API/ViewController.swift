//
//  ViewController.swift
//  WP REST API
//
//  Created by Peter Leung on 30/10/2016.
//  Copyright © 2016 winandmac Media. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //JSON
    let latestPosts : String = "https://wlcdesigns.com/wp-json/wp/v2/posts/"
    
    let parameters : [String:AnyObject] = [
        "filter[category_name]" : "tutorials" as AnyObject,
        "filter[posts_per_page]" : 5 as AnyObject
    ]
    
    var json : JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = "Text"
        return cell
    }


}

