//  PlaySoundsViewController.swift
//  PitchPerfect
//  Created by DavidKevinChen on 3/26/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

/* Notes
This file is created with auto-populated content by Swift/Xcode
Need to manually wire it up with the ViewController in Main.storybord
The code make use of a class extension, given by Udacity
 */

import UIKit;
import AVFoundation;

class PlaySoundsViewController: UIViewController {
    //MARK: - UI elements:
    @IBOutlet weak var slowButton: UIButton!;
    @IBOutlet weak var fastButton: UIButton!;
    @IBOutlet weak var highPitchButton: UIButton!;
    @IBOutlet weak var lowPitchButton: UIButton!;
    @IBOutlet weak var echoButton: UIButton!;
    @IBOutlet weak var reverbButton: UIButton!;
    
    @IBOutlet weak var stopButton: UIButton!
    
    /* MARK: - Constants */
    var recordedAudioURL: URL!;
    enum ButtonType: Int{case slow=0, fast, highPitch, lowPitch, echo, reverb};
    
    //MARK: - Initialize properties to be used by class extension (ref: Lesson 5.10)
    var audioFile: AVAudioFile!;
    var audioEngine: AVAudioEngine!;
    var audioPlayerNode: AVAudioPlayerNode!;
    var stopTimer: Timer!;
    
    /* MARK: - Override existing functions by adding Extension's functionality (ref. Lesson 5.10) */
    override func viewDidLoad() {
        super.viewDidLoad();
        print("PlaySoundsViewController started up OK...");
        setupAudio(); //from extension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        configureUI(.notPlaying); //from extension
    }
    
    /* MARK: - Custom methods invoking UI changes */
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play sound buttons is pressed!");
        
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5);
        case .fast:
            playSound(rate: 1.5);
        
        case .highPitch:
            playSound(pitch: 1000);
        case .lowPitch:
            playSound(pitch: -1000);
            
        case .echo:
            playSound(echo: true);
        case .reverb:
            playSound(reverb: true);
        }
        
        configureUI(.playing); //from extension
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("Stop button at the bottom of PlaySoundViewController pressed!");
        stopAudio(); //from extension
    }
}
