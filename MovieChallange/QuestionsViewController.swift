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

    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var pagerControls: UIPageControl!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let vcIDforTypeID:[String:String] = [
        Types.INFO_ID   : "q_simple",
        Types.IMAGE_ID  : "q_image",
        Types.AUDIO_ID  : "q_audio"
    ]
    
    var timeElapsed: Int = 0 {
        didSet{
            let hours = String(format: "%02d", timeElapsed/60/60)
            let minutes = String(format: "%02d", timeElapsed/60%60)
            let seconds = String(format: "%02d", timeElapsed%60)
            
            timer_lbl.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    var pageViewController: UIPageViewController!
    var questionViewControllers: [QuestionViewController]!
    var timer:NSTimer!
    
    @IBAction func submit(sender: UIButton) {
        timer.invalidate()
        var correctCounter = 0
        var unansweredCounter = 0
        for controller in questionViewControllers{
            if let correct = controller.isCorrect {
                if correct{
                    correctCounter++
                }
            }else{
                unansweredCounter++
            }
        }
        
        let alertController = UIAlertController(title: "Finnished", message: "You have \(correctCounter)/\(10 - unansweredCounter) answered correctly", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) in
            // go to home
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadQuestionsViewControllers(withBlock: {
            self.pageViewController!.setViewControllers([self.questionViewControllers![0]], direction: .Forward, animated: false, completion: nil)
            
            self.pagerControls.numberOfPages = (self.questionViewControllers?.count)!
            self.spinner.stopAnimating()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
        })
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController?.delegate = self
        
        pageViewController!.view.frame = CGRectMake(0, 0, pagerView.frame.size.width, pagerView.frame.size.height);
        
        addChildViewController(pageViewController!)
        pagerView.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    
    func timerTick(){
        timeElapsed++
    }
    
    func loadQuestionsViewControllers(withBlock callback: ()->()){
        questionViewControllers = []
        
        PFCloud.callFunctionInBackground("getInfoQuestions", withParameters: nil) { (result, error) -> Void in
            if (error != nil){
                print(error!)
            }else{
                if let questions = result as? [PFObject]{
                    print(questions.count)
                    for question in questions {
                        let vc_id = self.vcIDforTypeID[question["type"].objectId!!]
                        print(vc_id)
                        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier(vc_id!) as? QuestionViewController{
                            vc.dataObject = question
                            self.questionViewControllers?.append(vc)
                        }
                    }
                    callback()
                }
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers?.indexOf(viewController as! QuestionViewController))! + 1
        if index >= questionViewControllers?.count {
            return nil
        }
        return questionViewControllers![index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers?.indexOf(viewController as! QuestionViewController))! - 1
        if index < 0 {
            return nil
        }
        return questionViewControllers![index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentController = pageViewController.viewControllers?.first
        let index = questionViewControllers?.indexOf(currentController as! QuestionViewController)
        pagerControls.currentPage = index!
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return (questionViewControllers?.count)!
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
