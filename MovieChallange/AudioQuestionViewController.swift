//
//  AudioQuestionViewController.swift
//  MovieChallange
//
//  Created by Giorgi Rokhadze on 1/8/16.
//  Copyright © 2016 tornike abramishvili. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class AudioQuestionViewController: QuestionViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    private var audioPlayer: AVAudioPlayer!
    private var player: AVPlayer!
    
    @IBAction func answered(sender: UIButton) {
        if (sender.isEqual(answerA)) {
            print("shemovida a chemisa")
        }
        if (sender.isEqual(answerB)) {
            print("shemovida b chemisa")
        }
        if (sender.isEqual(answerC)) {
            print("shemovida c chemisa")
        }
        if (sender.isEqual(answerD)) {
            print("shemovida d chemisa")
        }
    }
    
    @IBAction func next(sender: UIButton) {
        
    }
    
    @IBAction func playMusic(sender: AnyObject) {
        let query = PFQuery(className: "AudioFile")
        query.whereKeyExists("audio")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            if error == nil {
                let audio = objects?[0]
                let audioFile = audio?["audio"] as? PFFile
                audioFile?.getDataInBackgroundWithBlock({ (audio: NSData?, error: NSError?) -> Void in
                    if audio != nil {
                        do {
                            self.audioPlayer = try AVAudioPlayer(data: audio!)
                            self.audioPlayer.prepareToPlay()
                            self.audioPlayer.delegate = self
                            self.audioPlayer.volume = 10.0
                            self.audioPlayer.play()
                        } catch {
                            print("Error occured while playing music!")
                        }
                    } else {
                        print ("Somehow audio is nil!")
                    }
                })
            } else {
                print("Error occured while downloading file!")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
