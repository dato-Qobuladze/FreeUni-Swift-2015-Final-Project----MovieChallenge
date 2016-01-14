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
            print("shemovida a chemisa")
            isCorrect = (correct == 0)
            a.backgroundColor = UIColor.lightGrayColor()
            b.backgroundColor = nil
            c.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(b)) {
            print("shemovida b chemisa")
            isCorrect = (correct == 1)
            b.backgroundColor = UIColor.lightGrayColor()
            a.backgroundColor = nil
            c.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(c)) {
            print("shemovida c chemisa")
            isCorrect = (correct == 2)
            c.backgroundColor = UIColor.lightGrayColor()
            a.backgroundColor = nil
            b.backgroundColor = nil
            d.backgroundColor = nil
        }
        if (sender.isEqual(d)) {
            print("shemovida d chemisa")
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
        a.layer.cornerRadius = 5
        b.layer.cornerRadius = 5
        c.layer.cornerRadius = 5
        d.layer.cornerRadius = 5
        
        if let question = dataObject{
            var answers = [ question["a"] as! String,
                            question["b"] as! String,
                            question["c"] as! String,
                            question["d"] as! String
                            ]
            
            let randIndex = Int(arc4random_uniform(4))
            correct = randIndex
            if randIndex != 0{
                swap(&answers[0], &answers[randIndex])
            }
            
            
            a.setTitle(titleFor("A", withAnswer: answers[0]), forState: .Normal)
            b.setTitle(titleFor("B", withAnswer: answers[1]), forState: .Normal)
            c.setTitle(titleFor("C", withAnswer: answers[2]), forState: .Normal)
            d.setTitle(titleFor("D", withAnswer: answers[3]), forState: .Normal)
        }

        // Do any additional setup after loading the view.
    }
    
    private func titleFor(button: String, withAnswer: String) -> String{
        return "\(button): \(withAnswer)"
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
