//
//  FirstViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 12/12/15.
//  Copyright © 2015 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIPopoverPresentationControllerDelegate {
    
    var pickerData: [String] = [String]()
    var pickerData1: [String] = [String]()
    var filmObjects: [PFObject]?
    var questObjects: [PFObject]?
    
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var SecondPicker: UIPickerView!
    @IBOutlet weak var Spinner: UIActivityIndicatorView!

    @IBAction func singlePlay(sender: UIButton) {
        let filmIndex = myPickerView.selectedRowInComponent(0)
        let questIndex = SecondPicker.selectedRowInComponent(0)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("questions") as? QuestionsViewController
        vc?.selectedFilm = filmObjects?[filmIndex].objectId
        vc?.selectedQuest = questObjects?[questIndex].objectId
        print(filmObjects![filmIndex])
        print(questObjects![questIndex])
        presentViewController(vc!, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myPickerView.delegate = self
        self.SecondPicker.delegate = self
        self.myPickerView.dataSource = self
        self.SecondPicker.dataSource = self
        
        Spinner.startAnimating()
        
        var query = PFQuery(className: "Films")
        query.whereKeyExists("film")
        filmObjects = [PFObject]?()
        
        do {
            filmObjects = try query.findObjects() as [PFObject]?
        } catch  {
            print("Download film categories error")
        }
        
        for film in filmObjects!{
            let filmStr = film["film"] as? String
            pickerData.append(filmStr!)
        }
        
        query = PFQuery(className: "Quests")
        query.whereKeyExists("quest")
        questObjects = [PFObject]?()
        do {
            questObjects = try query.findObjects() as [PFObject]?
        } catch  {
            print("Download quest categories error")
        }
        
        for quest in questObjects!{
            let questStr = quest["quest"] as? String
            pickerData1.append(questStr!)
        }
        
        Spinner.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == SecondPicker {
            return pickerData1.count
        }
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == SecondPicker {
            return pickerData1[row]
        }
        return pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! MultyPlayerViewController
        if let popoverController = dest.popoverPresentationController
        {
            popoverController.delegate = self
            let filmIndex = myPickerView.selectedRowInComponent(0)
            let questIndex = SecondPicker.selectedRowInComponent(0)
            dest.filmId  = filmObjects?[filmIndex].objectId
            dest.questId = questObjects?[questIndex].objectId
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
}

