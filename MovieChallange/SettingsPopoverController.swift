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
    var alertText : String = ""
    var alertStyle : UIAlertActionStyle = UIAlertActionStyle.Cancel
    var titleOfHandler : String = ""
    var makeAnyChanged : Bool = false

    
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
        if makeAnyChanged {
            showAlertWithMessage(alertText, style: alertStyle, handlerTitle: titleOfHandler)
        }
        alertText = ""
        makeAnyChanged = false
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
        if let newEmail = emailTextField.text {
            if newEmail != "" {
                
                alertText += Messages.emailFieldMsg.rawValue;
                alertStyle = UIAlertActionStyle.Default
                titleOfHandler = "Yes"
                
                makeAnyChanged = true
            }
        }
    }
    
    func passwordAction(){
        let passwordText = passwordField.text
        let confirmText  = confirmPasswordField.text
        
        if  passwordText != nil && confirmText != nil {
            if passwordText == confirmText {
                if passwordText != "" {
                    alertText += "\n" + Messages.changePasswordMsg.rawValue
                    alertStyle = UIAlertActionStyle.Default
                    titleOfHandler = "Yes"
                }
            }
            else {
                alertText = Messages.notSameFieldMsg.rawValue
                alertStyle = UIAlertActionStyle.Cancel
                titleOfHandler = "Cancel"
                makeAnyChanged = true
                
                // empty password fields
                passwordField.text = ""
                confirmPasswordField.text = ""
                
            }
        }
//        else {
//            showAlertWithMessage(Messages.emptyFieldMsg.rawValue,
//                                    style: UIAlertActionStyle.Cancel, handlerTitle: "Cancel")
//        }
    }
    
    func showAlertWithMessage(message: String, style: UIAlertActionStyle, handlerTitle: String){
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: handlerTitle, style: alertStyle, handler: { action in
            switch action.style{
            case .Default:
                print("default")
                self.dismissViewControllerAnimated(false, completion: nil) // close popover
                
            case .Cancel:
                print("cancel")
                
            case .Destructive:
                print("destructive")
            }
        }))
        
        if style == UIAlertActionStyle.Default {
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
