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

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func signIn(sender: UIButton) {
        if let name = username.text, let pass = password.text{
            PFUser.logInWithUsernameInBackground(name, password: pass) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("successfull")
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
        username.becomeFirstResponder()
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            print("Object has been saved.")
//        }
        
//        let user = PFUser()
//        user.username = "username"
//        user.password = "password"
//        user.email = "email@example.com"
//        
//        user.signUpInBackgroundWithBlock {
//            (succeeded: Bool, error: NSError?) -> Void in
//            if let error = error {
//                let errorString = error.userInfo["error"] as? NSString
//                print(errorString)
//                // Show the errorString somewhere and let the user try again.
//            } else {
//                print("signed up")
//                // Hooray! Let them use the app now.
//            }
//        }
    }
}
