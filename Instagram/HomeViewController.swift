//
//  HomeViewController.swift
//  Instagram
//
//  Created by Michaela Foote on 3/5/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var fullPost: [PFObject]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.estimatedRowHeight = 400
        tableView.separatorStyle = .None
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // [query whereKey:@"UserID" equalTo:@"user"];
        
        let currentUser = PFUser.currentUser()
        let query = PFQuery(className: "Post")
        query.whereKey("user", equalTo: currentUser!)
        
        query.orderByDescending("createdAt")
        query.includeKey("picture")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let results = results {
                    
                    self.fullPost = results
                    
                    print("Retrieved \(results.count) posts")
                    /*(for l in self.picsPlusCaption! {
                    print(l["caption"])
                    print(l["picture"])
                    }*/
                    self.tableView.reloadData()
                    self.tableView.separatorStyle = .None
                } else {
                    print("No results")
                }
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.fullPost != nil {
            return (self.fullPost?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        
        cell.fullPost = fullPost[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
