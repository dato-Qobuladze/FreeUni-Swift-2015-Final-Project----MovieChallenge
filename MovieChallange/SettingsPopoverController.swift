//
//  SettingsPopoverController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/9/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class SettingsPopoverController: UIViewController {
    
    typealias closure = () -> Void
    var actionsDict : [String : closure]? = [String : closure]()

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    @IBAction func passwordFieldAction(sender: UITextField) {
    }
    
    
    @IBAction func confirmFieldAction(sender: UITextField) {
    }
    
    
    @IBOutlet weak var changeButton: UIButton!
    
    
    @IBAction func changeButtonAction(sender: UIButton) {
        emailAction()
        passwordAction()
        // close popover . . .
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func emailAction(){
        if let _ = emailTextField.text {
            showAlertWithMessage(Messages.emptyFieldMsg.rawValue,
                                    alertStyle: UIAlertActionStyle.Default, handlerTitle: "Yes")
        }
    }
    
    func passwordAction(){
        let passwordText = passwordField.text
        let confirmText = confirmPasswordField.text
        
        if  passwordText != nil && confirmText != nil {
            if passwordText == confirmText {
                showAlertWithMessage(Messages.changePasswordMsg.rawValue,
                                        alertStyle: UIAlertActionStyle.Default, handlerTitle: "Yes")
            }
            showAlertWithMessage(Messages.notSameFieldMsg.rawValue,
                                    alertStyle: UIAlertActionStyle.Cancel, handlerTitle: "Cancel")
        }
        else {
            showAlertWithMessage(Messages.emptyFieldMsg.rawValue,
                                    alertStyle: UIAlertActionStyle.Cancel, handlerTitle: "Cancel")
        }
    }
    
    func showAlertWithMessage(message: String, alertStyle: UIAlertActionStyle, handlerTitle: String){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: handlerTitle, style: alertStyle, handler: { action in
            switch action.style{
            case .Default:
                print("default")
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        if alertStyle == UIAlertActionStyle.Default {
            alert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    enum Messages : String{
        case emailFieldMsg = "Do you want to change email?"
        case changePasswordMsg = "Do you want to change password?"
        case notSameFieldMsg = "There are not the same password and confirm password text."
        case emptyFieldMsg = "Please enter text in both fields: \n password and confirm password."
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
