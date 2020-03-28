/*
ViewController.swift
ColorMaker (sample app)
Template Created by Jason Schatz on 11/2/14
Code finished by David Chen, Udacity Student, on 3/27/20
Copyright (c) 2014 Udacity. All rights reserved.
 */

import UIKit;

// MARK: - ViewController: UIViewController
class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redControl: UISlider! //UISwitch if binary
    @IBOutlet weak var greenControl: UISlider!
    @IBOutlet weak var blueControl: UISlider!

    // MARK: - Activity lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        changeColorComponent();
    }
    
    // MARK: - Actions as methods
    @IBAction func changeColorComponent() {        
        if self.redControl == nil {return}
        
        // Binary RGB switches: DO NOT DELETE - KEEP AS REFERENCE
        // let r: CGFloat = self.redControl.isOn ? 1 : 0;
        // let g: CGFloat = self.greenControl.isOn ? 1 : 0;
        // let b: CGFloat = self.blueControl.isOn ? 1 : 0;
                
        // Continuous RGB slider: NAMED SAME AS BINARY SWITCHES
        let r: CGFloat = CGFloat(self.redControl.value);
        let g: CGFloat = CGFloat(self.greenControl.value);
        let b: CGFloat = CGFloat(self.blueControl.value);
        
        colorView.backgroundColor = UIColor(red:r, green:g, blue:b, alpha:1);
    }
}


