//
//  NotificationsTableViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/14/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class NotificationsTableViewController: UITableViewController {

    var data: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notification_cell", forIndexPath: indexPath) as? NotificationTableViewCell
        cell?.object = data?[indexPath.row]
        // Configure the cell...

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("questions") as? QuestionsViewController
        vc?.challenge = data?[indexPath.row]
        presentViewController(vc!, animated: true, completion: nil)
    }
    
}
