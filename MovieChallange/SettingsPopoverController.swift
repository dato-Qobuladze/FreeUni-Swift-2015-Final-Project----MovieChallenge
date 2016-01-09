//
//  SettingsPopoverController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/9/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class SettingsPopoverController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    @IBAction func passwordFieldAction(sender: UITextField) {
    }
    
    
    @IBAction func confirmFieldAction(sender: UITextField) {
    }
    
    
    @IBOutlet weak var changeButton: UIButton!
    
    
    @IBAction func changeButtonAction(sender: UIButton) {
    }
    
    
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
