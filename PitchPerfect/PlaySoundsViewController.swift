//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Sean Goldsborough on 4/10/17.
//  Copyright © 2017 Sean Goldsborough. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_sender: UIButton) {
        
        switch(ButtonType(rawValue: _sender.tag)!){
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 4.0)
        case .chipmunk:
            playSound(pitch: 1500)
        case .vader:
            playSound(pitch: -2400)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
            
        }
        configureUI(.playing)
        print("PLAY SOUND BUTTON PRESSED")
        stopButton.isEnabled = true
    }
    
    @IBAction func stopButtonPressed(_sender: AnyObject) {
        print("STOP SOUND BUTTON PRESSED")
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        snailButton.imageView?.contentMode = .scaleAspectFit
        chipmunkButton.imageView?.contentMode = .scaleAspectFit
        rabbitButton.imageView?.contentMode = .scaleAspectFit
        vaderButton.imageView?.contentMode = .scaleAspectFit
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.imageView?.contentMode = .scaleAspectFit
        
        setupAudio()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    

}

