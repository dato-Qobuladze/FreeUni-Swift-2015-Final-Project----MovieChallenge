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

class AudioQuestionViewController: UIViewController {

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
                let filePath = audioFile?.url
                let url = NSURL(fileURLWithPath: filePath!)
                let soundData = NSData(contentsOfURL: url)
                if soundData != nil {
                    do {
                        self.audioPlayer = try AVAudioPlayer(data: soundData!) // AVAudioPlayer(contentsOfURL: url)
                        self.audioPlayer.prepareToPlay()
                        self.audioPlayer.volume = 1.0
                        self.audioPlayer.play()
                    } catch {
                        print("Error occured while playing music!")
                    }
                } else {
                    print("Error occured while getting data!")
                }
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
