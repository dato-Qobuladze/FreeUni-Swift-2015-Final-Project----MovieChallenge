//
//  QuestionsViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/10/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse


public class Types {
    public static let INFO_ID : String = "5fa6TbPRUz"
    public static let IMAGE_ID: String = "lZF2Xizu0j"
    public static let AUDIO_ID: String = "pmz1lP5DVp"
}

class QuestionsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var userObjects: [PFObject]?

    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var pagerControls: UIPageControl!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var loadingData: Bool = false {
        didSet {
            if loadingData {
                spinner.startAnimating()
            } else {
                spinner.stopAnimating()
            }
            pageViewController.view.userInteractionEnabled = !loadingData
        }
    }
    
    private let vcIDforTypeID: [String:String] = [
        Types.INFO_ID   : "q_simple",
        Types.IMAGE_ID  : "q_image",
        Types.AUDIO_ID  : "q_audio"
    ]
    
    var timeElapsed: Int = 0 {
        didSet{
            timer_lbl.text = timerLabel
        }
    }
    
    private var timerLabel: String {
        let hours = String(format: "%02d", timeElapsed/60/60)
        let minutes = String(format: "%02d", timeElapsed/60%60)
        let seconds = String(format: "%02d", timeElapsed%60)
        return "\(hours):\(minutes):\(seconds)"
    }
    
    func timerTick() {
        if !loadingData {
            timeElapsed++
        }
    }
    
    var pageViewController: UIPageViewController!
    var questionViewControllers: [QuestionViewController]!
    weak var timer: NSTimer!
    
    var selectedFilm: String?
    var selectedQuest: String?
    var challenge: PFObject?
    private var questions: [PFObject]?
    
    @IBAction func submit(sender: UIButton) {
        timer.invalidate()
        var correctCounter = 0
        var unansweredCounter = 0
        for controller in questionViewControllers {
            if let correct = controller.isCorrect {
                if correct {
                    correctCounter++
                }
            } else {
                unansweredCounter++
            }
        }
        
        let score = correctCounter * 100 - timeElapsed
        print("INFO: User objects <" + String(userObjects) + ">")
        if let challengers = userObjects {
            print("INFO: Challengers")
            for opponent in challengers {
                let request = PFObject(className: "MultiplayHistory")
                request["yourName"] = PFUser.currentUser()?.username
                request["yourScore"] = score
                request["opponentName"] = opponent["username"] as! String
                let relation = request.relationForKey("questions")
                for question in questions! {
                    relation.addObject(question)
                }

                request.saveInBackground()
                let updatedScore = (PFUser.currentUser()!["score"] as? Int ?? 0) + score
                print("updated score: \(updatedScore)")
                PFUser.currentUser()!["score"] = updatedScore
                PFUser.currentUser()?.saveInBackground()
            }
        }
        
        if challenge != nil {
            challenge!["opponentScore"] = score
            challenge!["cancelled"] = false
            challenge?.saveInBackground()
            let updatedScore = (PFUser.currentUser()!["score"] as? Int ?? 0) + score
            PFUser.currentUser()!["score"] = updatedScore
            PFUser.currentUser()?.saveInBackground()
        }
        let alertController = UIAlertController(title: "Finnished", message: "You have \(correctCounter)/\(questionViewControllers.count - unansweredCounter) answered correctly in \(timerLabel), \nScore: \(score)", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {[unowned self] (action) in
            // Go to home! I say you are drunk!
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadQuestionsViewControllers(withBlock: {[unowned self] in
            if self.questionViewControllers.count == 0{
                let alertController = UIAlertController(title: "Sorry", message: "There are no such questions :(((", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
                    // Go home! You are drunk!
                    self.dismissViewControllerAnimated(true, completion: nil)
//                    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("home")
//                    self.presentViewController(vc!, animated: true, completion: nil)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                self.pageViewController.setViewControllers([self.questionViewControllers[0]], direction: .Forward, animated: false, completion: nil)
                
                self.pagerControls.numberOfPages = self.questionViewControllers.count
                self.spinner.stopAnimating()
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
            }
        })
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        pageViewController.view.frame = CGRectMake(0, 0, pagerView.frame.size.width, pagerView.frame.size.height);
        
        addChildViewController(pageViewController)
        pagerView.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
        
    }
    
    func loadQuestionsViewControllers(withBlock callback: ()->()){
        questionViewControllers = []
        if challenge != nil{
            challenge?.relationForKey("questions").query().findObjectsInBackgroundWithBlock({[unowned self] (result, error) -> Void in
                if let questions = result {
                    print(questions.count)
                    for question in questions {
                        self.questions = questions
                        let vc_id = self.vcIDforTypeID[question["type"].objectId!!]
                        print(vc_id)
                        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier(vc_id!) as? QuestionViewController{
                            vc.dataObject = question
                            vc.parent = self
                            vc.onAnswer = {
                                ()->() in
                                print("answered")
                                if let next = self.pageViewController(self.pageViewController, viewControllerAfterViewController: self.pageViewController.viewControllers![0]) {
                                    self.pageViewController.setViewControllers([next], direction: .Forward, animated: true, completion: nil)
                                    self.pageViewController(self.pageViewController, didFinishAnimating: false, previousViewControllers: [], transitionCompleted: false)
                                }
                                
                            }
                            self.questionViewControllers.append(vc)
                        }
                    }
                    callback()
                }
            })
        } else {
            var params:[String:String]? = nil
            if selectedFilm != nil && selectedQuest != nil {
                params = [  "film":selectedFilm!,
                            "quest":selectedQuest!]
            }
            print(params)
            PFCloud.callFunctionInBackground("getQuestions", withParameters: params) {[unowned self] (result, error) -> Void in
                if (error != nil) {
                    print(error!)
                } else {
                    if let questions = result as? [PFObject] {
                        self.questions = questions
                        print(questions.count)
                        for question in questions {
                            let vc_id = self.vcIDforTypeID[question["type"].objectId!!]
                            print(vc_id)
                            if let vc = self.storyboard?.instantiateViewControllerWithIdentifier(vc_id!) as? QuestionViewController{
                                vc.dataObject = question
                                vc.parent = self
                                vc.onAnswer = {
                                    ()->() in
                                    print("INFO: Answered! From QuestionsViewController")
                                    if let next = self.pageViewController(self.pageViewController, viewControllerAfterViewController: self.pageViewController.viewControllers![0]){
                                        self.pageViewController.setViewControllers([next], direction: .Forward, animated: true, completion: nil)
                                        self.pageViewController(self.pageViewController, didFinishAnimating: false, previousViewControllers: [], transitionCompleted: false)
                                    }
                                    
                                }
                                self.questionViewControllers.append(vc)
                            }
                        }
                        callback()
                    }
                }
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers.indexOf(viewController as! QuestionViewController))! + 1
        if index >= questionViewControllers.count {
            return nil
        }
        return questionViewControllers[index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers.indexOf(viewController as! QuestionViewController))! - 1
        if index < 0 {
            return nil
        }
        return questionViewControllers[index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentController = pageViewController.viewControllers?.first
        let index = questionViewControllers.indexOf(currentController as! QuestionViewController)
        pagerControls.currentPage = index!
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return questionViewControllers.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
