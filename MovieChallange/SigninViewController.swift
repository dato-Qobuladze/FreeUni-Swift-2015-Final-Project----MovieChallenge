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
    
    override func viewDidLoad() {
        if PFUser.currentUser() != nil{
            goToHome()
        }else{
            username.becomeFirstResponder()
        }
    }
    
    private func goToHome(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("home")
        self.presentViewController(vc!, animated: true, completion: nil)
    }
}
