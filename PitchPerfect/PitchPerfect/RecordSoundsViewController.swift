//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by DavidKevinChen on 3/26/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

// IBActions trigger code to run
// IBOutlets let code affect UI

// Pitch Perfect <- AV Foundation framework (API) <- Apple audio hardware
// Application Lifecycle: Not running, Foreground (inactive or active), Background, Suspended

// Stack views: alignment, distribution, spacing of UIs


import UIKit; //UILabel, UIButton, UIView, UIViewController
import AVFoundation;

/*
 ViewController is a subclass, ie inherits from, UIVC
 Implements delegate protocol / interface is implemented -- so that our ViewController can act as a 'delegate' for AV audio recorder
*/
class RecordSoundsViewController:UIViewController, AVAudioRecorderDelegate {
    
    // Add a reusable ViewController:
    var audioRecorder: AVAudioRecorder!;
    
    // Wire up the UI (make sure the solid dots are on!)
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    /* Start-up functionality */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false;
    }
    
    
    //MARK: Audio Record functionality in AVFoundation
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording in progress";
        stopRecordingButton.isEnabled = true;
        recordButton.isEnabled = false;

        // Constants related to audio storage:
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav";
        let pathArray = [dirPath, recordingName];
        let filePath = URL(string: pathArray.joined(separator: "/"));
        
        // AVAudioSession required to record; shared instance
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]); //want to set this as delegate
        audioRecorder.delegate = self; //set delegate
        audioRecorder.isMeteringEnabled = true;
        audioRecorder.prepareToRecord();
        audioRecorder.record();
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordButton.isEnabled = true;
        stopRecordingButton.isEnabled = false;
        recordingLabel.text = "Tap to Record";
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false) //inactivate sharedSession
    }

    //MARK: Triggers the segway (required by interface)
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Add a segway:
        if flag { //if successful...
            print("Finished recording");
            print("Send the saved path...");
            // stopRecording is the name/id of the segway
            // path is in the form of a URL
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url);
        } else {
            print("Recording unsuccessful");
        }
    }
    
    // MARK: Prepares the segway when the segway is called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Upcast the destination controller to the target ViewController
        let playSoundVC = segue.destination as! PlaySoundsViewController;
        let recordedAudioURL = sender as! URL;
        playSoundVC.recordedAudioURL = recordedAudioURL; //receives the URL, ready for playback
    }
}

