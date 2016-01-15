//
//  SignUpViewController.swift
//  MovieChallange
//
//  Created by Giorgi Rokhadze on 1/7/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func register(sender: UIButton) {
        if password.text == repeatPassword.text {
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
            spinner.startAnimating()
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                // self.spinner.stopAnimating()
                if let error = error {
                    // Show the errorString somewhere and let the user try again.
                    self.spinner.stopAnimating()
                    let errorString = error.userInfo["error"] as? NSString ?? ""
                    let alertController = UIAlertController(title: "Invalid Credentials", message: "\(errorString)", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    print(errorString)
                } else {
                    // Hooray! Let them use the app now.
                    print("INFO: Hooray! \(user.username!) use the app now.")
                    PFUser.logInWithUsernameInBackground(user.username!, password: user.password!) {
                        (user: PFUser?, error: NSError?) -> Void in
                        self.spinner.stopAnimating()
                        if user != nil {
                            // Do stuff after successful login.
                            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("home")
                            self.presentViewController(vc!, animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            
        } else {
            let alertController = UIAlertController(title: "Invalid Credentials", message: "Passwords do not match!", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Retry", style: .Default, handler: { (action) in
                self.clearFields()
                self.username.becomeFirstResponder()
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }

    }
    
    private func clearFields() {
        self.password.text = "";
        self.repeatPassword.text = "";
    }
    
}
