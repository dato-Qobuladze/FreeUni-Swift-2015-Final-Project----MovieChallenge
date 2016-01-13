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
    
    var popoverStartPoint : CGPoint!
    var settingsPopoverSize : CGSize {
        return CGSize(width: 200, height: 200)
    }
    
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
    
//    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
////        print(sender.view)
////        
////        if let targetView = sender.view as? UIImageView{
////            print("click images")
////        }
//        
//    }
    
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
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func ratingAction(sender: UIButton) {
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        popoverStartPoint = calculateStartPoint()
        
        if let user = PFUser.currentUser() {
            setUserProfileTexts(userObject: user)
            setUserProfileImage(userObject: user)
        }
    }
    
    func setUserProfileTexts(userObject user: PFUser) {
        if user.objectForKey("username") != nil {
            let userName = user.objectForKey("username") as! String
            let userEmail = user.objectForKey("email") as! String
//            let currentScore = user.objectForKey("score") as! Double
        
        
            usernameLabel.text = userName
            mailLabel.text = userEmail
//            scoreLabel.text = String(currentScore)
            // appropriate color
        }
    }
    
    
    func setUserProfileImage(userObject user: PFUser){
        if let imageFile = user.objectForKey("profileImage") as? PFFile {
            imageFile.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                if let imgData = imageData {
                    self.profileImage.image = UIImage(data: imgData)
                }
                
            })
        }
    }
    
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//        popoverStartPoint = calculateStartPoint()
    }
    
    func calculateStartPoint() -> CGPoint {
        
        return  CGPoint(x: view.bounds.midX - settingsPopoverSize.width / 2,
                        y: view.bounds.midY - settingsPopoverSize.height / 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
}

