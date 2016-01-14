//
//  ImageQuestionViewController.swift
//  MovieChallange
//
//  Created by Giorgi Rokhadze on 1/9/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class ImageQuestionViewController: QuestionViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.04
            scrollView.maximumZoomScale = 4.0
        }
    }
    @IBOutlet weak var text: UILabel!
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            scrollView.zoomToRect(imageView.bounds, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = dataObject?["text"] as? String
        // Do any additional setup after loading the view.
        scrollView.addSubview(imageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        if self.image == nil{
            if let data = dataObject{
                if let file = data["data"] as? PFFile{
                    parent.loadingData = true
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        self.parent.loadingData = false
                        if let imgData = imageData {
                            self.image = UIImage(data: imgData)
                        }
                    })
                }
                
            }
        }
    }

}
