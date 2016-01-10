//
//  QuestionsViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 1/10/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var pagerView: UIView!
    @IBOutlet weak var pagerControls: UIPageControl!
    
    var timeElapsed: Int = 0 {
        didSet{
            let hours = String(format: "%02d", timeElapsed/60/60)
            let minutes = String(format: "%02d", timeElapsed/60%60)
            let seconds = String(format: "%02d", timeElapsed%60)
            
            timer_lbl.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    var pageViewController: UIPageViewController?
    var questionViewControllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsViewControllers()
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController?.delegate = self
        
        pageViewController!.setViewControllers([questionViewControllers![0]], direction: .Forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRectMake(0, 0, pagerView.frame.size.width, pagerView.frame.size.height);
        
        addChildViewController(pageViewController!)
        pagerView.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
    }
    
    func timerTick(){
        timeElapsed++
    }
    
    func loadQuestionsViewControllers(){
        let q1 = storyboard?.instantiateViewControllerWithIdentifier("q_simple")
        let q2 = storyboard?.instantiateViewControllerWithIdentifier("q_image")
        let q3 = storyboard?.instantiateViewControllerWithIdentifier("q_audio")
        let q4 = storyboard?.instantiateViewControllerWithIdentifier("q_image")
        questionViewControllers = [q1!, q2!, q3!, q4!]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers?.indexOf(viewController))! + 1
        if index >= questionViewControllers?.count {
            return nil
        }
        return questionViewControllers![index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = (questionViewControllers?.indexOf(viewController))! - 1
        if index < 0 {
            return nil
        }
        return questionViewControllers![index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentController = pageViewController.viewControllers?.first
        let index = questionViewControllers?.indexOf(currentController!)
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
