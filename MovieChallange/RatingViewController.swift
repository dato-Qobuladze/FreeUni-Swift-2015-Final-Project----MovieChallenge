//
//  RatingViewController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var userRatingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var multiplayerHistoryTable: UITableView!
    
    
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
