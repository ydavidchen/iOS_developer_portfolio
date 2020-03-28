//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by DavidKevinChen on 3/26/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

// This file is created with auto-populated content by Swift/Xcode
// Need to manually wire it up with the ViewController in Main.storybord

/* We will also make use of a class extension, given by Udacity */


import UIKit;
import AVFoundation;

class PlaySoundsViewController: UIViewController {
    // UI elements:
    @IBOutlet weak var slowButton: UIButton!;
    @IBOutlet weak var fastButton: UIButton!;
    @IBOutlet weak var highPitchButton: UIButton!;
    @IBOutlet weak var lowPitchButton: UIButton!;
    @IBOutlet weak var echoButton: UIButton!;
    @IBOutlet weak var reverbButton: UIButton!;
    
    @IBOutlet weak var stopButton: UIButton!
    
    // Audio delegate: (Lesson 4)
    var recordedAudioURL: URL!;
    
    // Objects to be used by class extension given by Udacity instructor: (Lesson 5.10)
    var audioFile: AVAudioFile!;
    var audioEngine: AVAudioEngine!;
    var audioPlayerNode: AVAudioPlayerNode!;
    var stopTimer: Timer!;

    enum BUTTONTYPE: Int{case slow=0, fast, highPitch, lowPitch, echo, reverb};

    /*
     Override existing functions by adding Extension's functionality
     Lesson 5.10
     */
    override func viewDidLoad() {
        super.viewDidLoad();
        print("PlaySoundsViewController started up OK...");
        setupAudio(); //extension method
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        configureUI(.notPlaying); //extension method, pass in the not-playing state
    }
    
    /*
     Custom methods invoking UI changes
     */
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play sound buttons is pressed!");
        
        // Refer to tag created:
        switch(BUTTONTYPE(rawValue: sender.tag)!) {
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
        
        configureUI(.playing);
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("Stop button at the bottom of PlaySoundViewController pressed!");
        stopAudio(); //extension function that invokes AVFundation
    }
}
