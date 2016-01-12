//
//  ImageQuestionViewController.swift
//  MovieChallange
//
//  Created by Giorgi Rokhadze on 1/9/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class ImageQuestionViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

}
