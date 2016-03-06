//
//  HomeViewController.swift
//  Instagram
//
//  Created by Michaela Foote on 3/5/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
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
