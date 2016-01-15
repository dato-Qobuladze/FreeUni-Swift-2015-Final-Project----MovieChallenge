//
//  SigninViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/7/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class SigninViewController: UIViewController {

    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func signIn(sender: UIButton) {
        if let name = username.text, let pass = password.text{
            spinner.startAnimating()
            PFUser.logInWithUsernameInBackground(name, password: pass) {
                (user: PFUser?, error: NSError?) -> Void in
                self.spinner.stopAnimating()
                if user != nil {
                    // Do stuff after successful login.
                    self.goToHome()
                } else {
                    let alertController = UIAlertController(title: "Invalide Credentials", message: "Incorrect Username or Password", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .Default, handler: { (action) in
                        self.username.text = ""
                        self.password.text = ""
                        self.username.becomeFirstResponder()
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }else{
            print("not if")
            print(username.text)
            print(password.text)
        }
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        let alertController = UIAlertController(title: "Reset Password", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Email"
            textField.keyboardType = .EmailAddress
        })
        alertController.addAction(UIAlertAction(title: "Reset", style: .Default, handler: { (action) in
            let email = alertController.textFields?[0].text
            PFUser.requestPasswordResetForEmailInBackground(email!, block: { (sent, error) -> Void in
                let info = sent ? "Reset link is sent to your mail" : "Wrong email address"
                let infoAlert = UIAlertController(title: nil, message: info, preferredStyle: .Alert)
                infoAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(infoAlert, animated: true, completion: nil)
            })
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        username.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        username.text = ""
        password.text = ""
    }
    
    private func goToHome(){
        if (presentingViewController != nil){
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(vc!, animated: true, completion: nil)
        }
    }
}
