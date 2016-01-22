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
            var opponentName = data?["opponentName"] as! String
            let opponentScore = data?["opponentScore"] as? Double
            var yourName = data?["yourName"] as! String
            let yourScore = data?["yourScore"] as! Double
            
            if opponentScore == nil {
                return
            }
            
            if let currentUser = PFUser.currentUser() {
                
                if opponentName == currentUser["username"] as! String {
                    opponentName = yourName
                    yourName = currentUser["username"] as! String
                }
            }
            
            let fullEntry = opponentName + "  \(opponentScore!) VS \(yourScore)"
            
            dataLabel.text = fullEntry;
            
            let query = PFQuery(className: "_User")
            query.whereKey("username", equalTo: opponentName)
            
            query.findObjectsInBackgroundWithBlock { (users, error) -> Void in
                if users != nil {
                    self.setUserProfileImage(userObject: users![0] as! PFUser)
                }
            }
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
