//
//  MultyPlayerViewController.swift
//  MovieChallange
//
//  Created by mikheil maghriani on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class MultyPlayerViewController: UIViewController {

    @IBOutlet weak var PlayersSearch: UITextField!
    @IBOutlet weak var userImageView1: UIImageView!
    @IBOutlet weak var userImageView2: UIImageView!
    @IBOutlet weak var userImageView3: UIImageView!
    @IBOutlet weak var userImageView4: UIImageView!
    @IBOutlet weak var userImageView5: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var userLabel1: UILabel!
    @IBOutlet weak var userLabel2: UILabel!
    @IBOutlet weak var userLabel3: UILabel!
    @IBOutlet weak var userLabel4: UILabel!
    @IBOutlet weak var userLabel5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
