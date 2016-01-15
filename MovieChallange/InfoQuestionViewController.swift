//
//  InfoQuestionViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/12/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class InfoQuestionViewController: QuestionViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let data = dataObject {
            textView.text = data["text"] as! String
        }
    }

}
