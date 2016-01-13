//
//  HistoryCellViewController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/13/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class HistoryCellViewController: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var data: PFObject? {
        didSet{
            let opponentName = data?["opponentName"] as! String
            let opponentScore = data?["opponentScore"] as! Double
            let yourScore = data?["yourScore"] as! Double
            let isWin = data?["result"] as! Int
            
            var fullEntry = opponentName + "   " + String(opponentScore) + "   " + String(yourScore) + "   "
            if isWin == 1 {
                fullEntry += "You Win"
            }
            else if isWin == -1 {
                fullEntry += "You Loose"
            }
            else {
                fullEntry += "Draw"
            }
            
            dataLabel.text = fullEntry;

//            if let imageUrl = data?["profileImage"] {
//                
////                let imageUrl = 
//                let qInt = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
//                let queue = dispatch_get_global_queue(qInt, 0)
//                
//                dispatch_async(queue, { () -> Void in
//                    
//                    let imageData = NSData(contentsOfURL: imageUrl)
//                    
//                    if imageData != nil {
//                        let image = UIImage(data: imageData!)
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            self.userAvatar.image = image
//                        })
//                    }
//                })
//                
//            }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
