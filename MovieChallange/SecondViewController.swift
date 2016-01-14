//
//  SecondViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 12/12/15.
//  Copyright © 2015 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController, UIPopoverPresentationControllerDelegate,
                            UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var mailLabel: UILabel!
    
    
    @IBAction func settingsAction(sender: UIButton) {
//        self.performSegueWithIdentifier("settingsPopover", sender: self)
    }
    
    @IBAction func changeProfileImage(sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let user = PFUser.currentUser() {
            if let imageData = UIImageJPEGRepresentation(profileImage.image!, 1){
                let file = PFFile(data: imageData)
                user.setObject(file!, forKey: ParseColumn.UserImage.rawValue)
                user.saveInBackground()
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func ratingAction(sender: UIButton) {
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController
        if let popoverController = dest.popoverPresentationController
        {
            popoverController.delegate = self
            
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = PFUser.currentUser() {
            setUserProfileTexts(userObject: user)
            setUserProfileImage(userObject: user)
        }
    }
    
    func setUserProfileTexts(userObject user: PFUser) {
        if user.objectForKey(ParseColumn.Username.rawValue) != nil {
            let userName = user.objectForKey(ParseColumn.Username.rawValue) as! String
            let userEmail = user.objectForKey(ParseColumn.userEmail.rawValue) as! String
            let currentScore = user.objectForKey(ParseColumn.UserScore.rawValue) as! Double
        
        
            usernameLabel.text = userName
            mailLabel.text = userEmail
            scoreLabel.text = "Score: " + String(currentScore)
            // appropriate color
        }
    }
    
    
    func setUserProfileImage(userObject user: PFUser){
        if let imageFile = user.objectForKey(ParseColumn.UserImage.rawValue) as? PFFile {
            imageFile.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if let imgData = imageData {
                    self.profileImage.image = UIImage(data: imgData)
                }
                
            })
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    enum ParseColumn : String {
        case Username = "username"
        case userEmail = "email"
        case UserScore = "score"
        case UserImage = "profileImage"
    }
    
}

