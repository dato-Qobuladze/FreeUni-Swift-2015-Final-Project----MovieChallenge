//
//  RatingViewController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class RatingViewController: UITableViewController, UITextFieldDelegate  { // UIViewController

    @IBOutlet weak var userRatingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let userQuery = PFUser.query()
//        userQuery?.whereKey("username", equalTo: "iOS")
//        userQuery?.findObjectsInBackgroundWithBlock({ (users, error) -> Void in
//            self.findoutRatingOf(users![0])
//            self.findGameEntryOf(users![0])
//        })
        
        if let user = PFUser.currentUser() {
            print("inViewDidload")
            findGameEntryOf(user)
        }
        
        
    }

    var gamesEntry = [PFObject]()
    
    func findGameEntryOf(user: PFUser){
        let query = PFQuery(className: "MultiplayHistory")
        
        query.whereKey("yourName", equalTo: user["username"])
        do {
            gamesEntry = try query.findObjects() as [PFObject]
            
            print("gamesEntry: \(gamesEntry)")
        } catch  {
            print("error history")
        }
        
        let query2 = PFQuery(className: "MultiplayHistory")
        query2.whereKey("opponentName", equalTo: user["username"])
        do {
            let other = try query2.findObjects() as [PFObject]
            gamesEntry += other
//            gamesEntry.appendContentsOf(other)
            
            print("both: \(other)")
        } catch  {
            print("error history")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return gamesEntry.count;
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! HistoryCellViewController
        
        
        let userGameEntry = gamesEntry[indexPath.row]
        cell.data = userGameEntry
        
        return cell
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
