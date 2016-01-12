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
    
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    @IBOutlet weak var SecondPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var pickerData1: [String] = [String]()
    
    @IBOutlet weak var Spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.SecondPicker.delegate = self
        self.SecondPicker.dataSource = self
        Spinner.startAnimating()
        var query = PFQuery(className: "Films")
        query.whereKeyExists("film")
        var objects : [PFObject]? = [PFObject]?()
        
        do {
            objects = try query.findObjects() as [PFObject]?
        } catch  {
            print("Download film categories error")
        }
        
        for film in objects!{
            let filmStr = film["film"] as? String
            pickerData.append(filmStr!)
        }
        
        query = PFQuery(className: "Quests")
        query.whereKeyExists("quest")
        do {
            objects = try query.findObjects() as [PFObject]?
        } catch  {
            print("Download quest categories error")
        }
        
        for quest in objects!{
            let questStr = quest["quest"] as? String
            pickerData1.append(questStr!)
        }
        
        Spinner.stopAnimating()
        // Do any additional setup after loading the view, typically from a nib.
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
        if pickerView == SecondPicker{
            return pickerData1.count
        }
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == SecondPicker{
            return pickerData1[row]
        }
        
        
        return pickerData[row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController
        if let popoverController = dest.popoverPresentationController
        {
            popoverController.delegate = self
            
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    
    
}

