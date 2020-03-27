//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by DavidKevinChen on 3/26/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

// This file is created with auto-populated content by Swift/Xcode
// Need to manually wire it up with the ViewController in Main.storybord

import UIKit

class PlaySoundsViewController: UIViewController {

    // UI elements:
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    
    // Audio delegate:
    var recordedAudioURL: URL!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("PlaySoundsViewController started up OK...");
    }
    
    /* Custom methods */
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play sound buttons is pressed!");
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("Stop button at the bottom of PlaySoundViewController pressed!");
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
