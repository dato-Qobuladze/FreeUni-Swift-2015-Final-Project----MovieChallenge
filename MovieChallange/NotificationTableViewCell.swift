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
    
    @IBAction func play(sender: UIButton) {
        
    }
    
    var object: PFObject?{
        didSet{
            if object != nil && username != nil{
                username.text = object!["opponentName"] as? String ?? ""
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
