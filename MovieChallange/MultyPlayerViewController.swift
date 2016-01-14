//
//  MultyPlayerViewController.swift
//  MovieChallange
//
//  Created by mikheil maghriani on 1/11/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse


extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            let hexColor = hexString.substringFromIndex(start)
            
            if hexColor.characters.count == 8 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}



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
            let color = colorStr! + "ff"

            if (count == 0){
                userLabel1.textColor = UIColor(hexString: color)
                userLabel1.text = userName
                userLabel1.hidden = false
                if let file = userObjects?[0]["profileImage"] as? PFFile{
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        if let imgData = imageData {
                           self.userImageView1.image = UIImage(data: imgData)
                           self.userImageView1.hidden = false
                        }
                    })
                }
                
            }
            if (count == 1){
                userLabel2.textColor = UIColor(hexString: color)
                userLabel2.text = userName
                userLabel2.hidden = false
                if let file = userObjects?[0]["profileImage"] as? PFFile{
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        if let imgData = imageData {
                            self.userImageView2.image = UIImage(data: imgData)
                            self.userImageView2.hidden = false
                        }
                    })
                }
            }
            if (count == 2){
                userLabel3.textColor = UIColor(hexString: color)
                userLabel3.text = userName
                userLabel3.hidden = false
                if let file = userObjects?[0]["profileImage"] as? PFFile{
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        if let imgData = imageData {
                            self.userImageView3.image = UIImage(data: imgData)
                            self.userImageView3.hidden = false
                        }
                    })
                }
            }
            if (count == 3){
                userLabel4.textColor = UIColor(hexString: color)
                userLabel4.text = userName
                userLabel4.hidden = false
                if let file = userObjects?[0]["profileImage"] as? PFFile{
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        if let imgData = imageData {
                            self.userImageView4.image = UIImage(data: imgData)
                            self.userImageView4.hidden = false
                        }
                    })
                }
            }
            if (count == 4){
                userLabel5.textColor = UIColor(hexString: color)
                userLabel5.text = userName
                userLabel5.hidden = false
                if let file = userObjects?[0]["profileImage"] as? PFFile{
                    file.getDataInBackgroundWithBlock({(imageData: NSData?, error: NSError?) -> Void in
                        if let imgData = imageData {
                            self.userImageView5.image = UIImage(data: imgData)
                            self.userImageView5.hidden = false
                        }
                    })
                }
                
            }
            
            if(count == 0){
                playButton.hidden = false
            }
            
            count++
            print(color)
            print(UIColor(hexString: "#ffe700ff"))
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
