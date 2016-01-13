//
//  RatingViewController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class RatingViewController: UIViewController {

    @IBOutlet weak var userRatingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userQuery = PFUser.query()
        userQuery?.whereKey("username", equalTo: "iOS")
        userQuery?.findObjectsInBackgroundWithBlock({ (users, error) -> Void in
            self.findoutRatingOf(users![0])
        })
        
//        if let user = PFUser.currentUser() {
//            findoutRatingOf(user)
//        }
    }

    func findGameEntry(){
        let gamesQuery = PFObject.query()
//        gamesQuery.wh
    }
    
    @IBOutlet weak var multiplayerHistoryTable: UITableView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    
    func findoutRatingOf(user: PFObject){
        if let score = user["score"] as? Double {
            print("score is: \(score)")
            let showLabelText : String = LabelsEnum.RatingLabel.rawValue + String(score)
            userRatingLabel.text = showLabelText
        }
    }
    
    
    enum LabelsEnum : String {
        case RatingLabel = "Your score: "
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
