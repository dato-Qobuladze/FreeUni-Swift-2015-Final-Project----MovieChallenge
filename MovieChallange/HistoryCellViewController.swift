//
//  HistoryCellViewController.swift
//  MovieChallange
//
//  Created by dato qobuladze on 1/13/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class HistoryCellViewController: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
