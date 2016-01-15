//
//  QuestionViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/12/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class QuestionViewController: UIViewController {

    var dataObject: PFObject?
    
    @IBOutlet weak var a: UIButton!
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var c: UIButton!
    @IBOutlet weak var d: UIButton!
    
    private var correct: Int?
    var isCorrect: Bool?
    var onAnswer:(()->())?
    var parent: QuestionsViewController!
    
    
    @IBAction func answer(sender: UIButton) {
        if (sender.isEqual(a)) {
            print("INFO: User chose A!")
            isCorrect = (correct == 0)
            a.backgroundColor = UIColor.lightGrayColor()
            b.backgroundColor = nil
            c.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(b)) {
            print("INFO: User chose B!")
            isCorrect = (correct == 1)
            b.backgroundColor = UIColor.lightGrayColor()
            a.backgroundColor = nil
            c.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(c)) {
            print("INFO: User chose C!")
            isCorrect = (correct == 2)
            c.backgroundColor = UIColor.lightGrayColor()
            a.backgroundColor = nil
            b.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(d)) {
            print("INFO: User chose D!")
            isCorrect = (correct == 3)
            d.backgroundColor = UIColor.lightGrayColor()
            a.backgroundColor = nil
            b.backgroundColor = nil
            c.backgroundColor = nil
        }
        onAnswer?()
        print(isCorrect)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        a.layer.cornerRadius = 5
        b.layer.cornerRadius = 5
        c.layer.cornerRadius = 5
        d.layer.cornerRadius = 5
        
        if let question = dataObject {
            var answers = [
                question["a"] as! String,
                question["b"] as! String,
                question["c"] as! String,
                question["d"] as! String
            ]
            
            let randIndex = Int(arc4random_uniform(4))
            correct = randIndex
            if randIndex != 0 {
                swap(&answers[0], &answers[randIndex])
            }
            
            a.setTitle(titleFor("A", withAnswer: answers[0]), forState: .Normal)
            b.setTitle(titleFor("B", withAnswer: answers[1]), forState: .Normal)
            c.setTitle(titleFor("C", withAnswer: answers[2]), forState: .Normal)
            d.setTitle(titleFor("D", withAnswer: answers[3]), forState: .Normal)
        }
    }
    
    private func titleFor(button: String, withAnswer: String) -> String{
        return "\(button): \(withAnswer)"
    }

}
