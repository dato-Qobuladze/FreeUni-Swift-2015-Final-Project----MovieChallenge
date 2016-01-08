//
//  SecondViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 12/12/15.
//  Copyright © 2015 tornike abramishvili. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel!
    
    
    @IBAction func settingsAction(sender: UIButton) {
        self.performSegueWithIdentifier("settingsPopover", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let dest = segue.destinationViewController
            if let popoverController = dest.popoverPresentationController
            {
                popoverController.delegate = self
                if segue.identifier == "settingsPopover"
                {
//                    popoverController.preferredContentSize = CGSize(width: 300, height: 3 * 40 + 40)
                }
                else if segue.identifier == "ratingPopover"
                {
                
                }
            }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    
    @IBAction func ratingAction(sender: UIButton) {
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

