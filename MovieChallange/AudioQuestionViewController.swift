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
    
    private var audioPlayer: AVAudioPlayer!
    private var isPlaying = false
    
    @IBAction func playMusic(sender: AnyObject) {
        parent.loadingData = true
        let audio = dataObject
        let audioFile = audio?["data"] as? PFFile
        audioFile?.getDataInBackgroundWithBlock({[unowned self] (audio: NSData?, error: NSError?) -> Void in
            self.parent.loadingData = false
            if audio != nil {
                do {
                    self.audioPlayer = try AVAudioPlayer(data: audio!)
                    self.audioPlayer.delegate = self
                    self.audioPlayer.prepareToPlay()
                    self.audioPlayer.volume = 10.0
                    self.audioPlayer.play()
                    self.isPlaying = true
                } catch {
                    print("ERROR: Something went wrong while playing music!")
                }
            } else {
                print ("ERROR: Somehow audio is nil!")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionText.text = dataObject?["text"] as? String
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after disappearing the view.
        if self.isPlaying {
            self.audioPlayer.stop()
            self.audioPlayer.delegate = nil
            self.audioPlayer = nil
        }
    }

}
