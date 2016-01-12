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
        if let data = dataObject{
            textView.text = data["text"] as! String
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}