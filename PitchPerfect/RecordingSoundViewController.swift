//
//  RecordingSoundViewController.swift
//  PitchPerfect
//
//  Created by Sean Goldsborough on 4/5/17.
//  Copyright © 2017 Sean Goldsborough. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(isRecording: false)
    }
    
    func configureUI(isRecording: Bool) {
        if isRecording == true {
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        } else {
            recordingLabel.text = "Tap to Record"
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        print("Button has been pressed!")
        configureUI(isRecording: true)
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))

        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("Stop button has been pressed!")
        configureUI(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording unsuccessful")
            errorAlert()
            
        }
    }
    
    func errorAlert() {
        let alertController = UIAlertController(title: "Uh Oh!", message: "Recording Unsuccessful", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alertController.addAction(tryAgain)
        configureUI(isRecording: false)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}
    
