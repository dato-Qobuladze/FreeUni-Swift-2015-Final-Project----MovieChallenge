//
//  FirstViewController.swift
//  MovieChallange
//
//  Created by tornike abramishvili on 12/12/15.
//  Copyright © 2015 tornike abramishvili. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    @IBOutlet weak var SecondPicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var pickerData1: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.SecondPicker.delegate = self
        self.SecondPicker.dataSource = self
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        pickerData1 = ["abc", "adjfh", "adfdf", "rgth", "dnde", "efek"]
        
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
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == myPickerView{
            return pickerData[row]
        }
        if pickerView == SecondPicker{
            return pickerData1[row]
        }
        
        
        return pickerData[row]
    }
    
    
    
}

