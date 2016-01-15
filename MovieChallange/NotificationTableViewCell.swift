//
//  NotificationTableViewCell.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/14/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBAction func cancel(sender: UIButton) {
        object?["cancelled"] = true
        object?.saveInBackground()
    }
    
    var object: PFObject?{
        didSet{
            if object != nil && username != nil{
                username.text = object!["yourName"] as? String ?? ""
                if let avatar = object?["profileImage"] as? PFFile{
                    avatar.getDataInBackgroundWithBlock({ (image, error) -> Void in
                        if let img = image{
                            self.avatar.image = UIImage(data: img)
                        }
                    })
                }
            }
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
