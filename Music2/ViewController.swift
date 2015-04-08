//
//  ViewController.swift
//  Music2
//
//  Created by Jinfeng Huang on 15/3/21.
//  Copyright (c) 2015年 Jinfeng Huang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player = AVAudioPlayer()
    
    var files = ["music0", "music1", "music2", "music3", "music4", "music5", "music6"]
    var musicIndex = 0

    @IBOutlet weak var volume: UISlider!
    
    @IBAction func play(sender: UIBarButtonItem) {
        player.play()
    }
    
    @IBAction func pause(sender: UIBarButtonItem) {
        player.pause()
    }
    
    @IBAction func stop(sender: UIBarButtonItem) {
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func changeVolume(sender: UISlider) {
        player.volume = volume.value
    }
    
    func randomPlay() {
        var randNum = Int(arc4random_uniform(UInt32(files.count)))
        while randNum == musicIndex {
            randNum = Int(arc4random_uniform(UInt32(files.count)))
        }
        musicIndex = randNum
        var audioPath = NSBundle.mainBundle().pathForResource(files[musicIndex], ofType: "mp3") ?? ""
        var error: NSError? = nil
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
        player.play()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            randomPlay()
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        randomPlay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var audioPath = NSBundle.mainBundle().pathForResource("music0", ofType: "mp3") ?? ""
        var error: NSError? = nil
        player = AVAudioPlayer(contentsOfURL: NSURL(string: audioPath), error: &error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

