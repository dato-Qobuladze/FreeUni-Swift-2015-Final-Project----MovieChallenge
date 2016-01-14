//
//  MultyPlayerViewController.swift
//  MovieChallange
//
//  Created by mikheil maghriani on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse

class MultyPlayerViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var userImageView1: UIImageView!
    @IBOutlet weak var userImageView2: UIImageView!
    @IBOutlet weak var userImageView3: UIImageView!
    @IBOutlet weak var userImageView4: UIImageView!
    @IBOutlet weak var userImageView5: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var userLabel1: UILabel!
    @IBOutlet weak var userLabel2: UILabel!
    @IBOutlet weak var userLabel3: UILabel!
    @IBOutlet weak var userLabel4: UILabel!
    @IBOutlet weak var userLabel5: UILabel!
    
    var filmId: String?
    var questId: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    //    print("searchText \(searchText)")
    //}
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text!)")
        addLine(searchBar.text!)
    }

    var count  = 0
    
    func addLine(userName : String){
        var userObjects: [PFObject]?
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: userName)
        userObjects = [PFObject]?()
        
        do {
            userObjects = try query.findObjects() as [PFObject]?
        } catch  {
            print("Download film categories error")
        }
        if (userObjects?.count > 0){
            print("shemovida")
            let colorStr = userObjects?[0]["color"] as? String
            let color = colorStr!
            if (count == 0){
                userLabel1.text = userName
                userLabel1.hidden = false
            }
            if (count == 1){
                userLabel2.text = userName
                userLabel2.hidden = false
            }
            if (count == 2){
                userLabel3.text = userName
                userLabel3.hidden = false
            }
            if (count == 3){
                userLabel4.text = userName
                userLabel4.hidden = false
            }
            if (count == 4){
                userLabel5.text = userName
                userLabel5.hidden = false
                
            }
            if(count == 0){
                playButton.hidden = false
            }
            
            count++
            print(color)
        }
        

        }
    
   /* @IBAction func singlePlay(sender: UIButton) {
        let filmIndex = myPickerView.selectedRowInComponent(0)
        let questIndex = SecondPicker.selectedRowInComponent(0)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("questions") as? QuestionsViewController
        vc?.selectedFilm = filmObjects?[filmIndex].objectId
        vc?.selectedQuest = questObjects?[questIndex].objectId
        print(filmObjects![filmIndex])
        print(questObjects![questIndex])
        presentViewController(vc!, animated: true, completion: nil)
        
    }*/

        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
