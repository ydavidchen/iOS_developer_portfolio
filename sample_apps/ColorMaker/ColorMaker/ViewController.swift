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
    
    @IBOutlet weak var redControl: UISwitch!
    @IBOutlet weak var greenControl: UISwitch!
    @IBOutlet weak var blueControl: UISwitch!

    // MARK: - Activity lifecycle
    override func viewDidLoad() {
        super.viewDidLoad();
        changeColorComponent();
    }
    
    // MARK: - Actions as methods
    @IBAction func changeColorComponent() {        
        if self.redControl == nil {return}
        let r: CGFloat = self.redControl.isOn ? 1 : 0;
        let g: CGFloat = self.greenControl.isOn ? 1 : 0;
        let b: CGFloat = self.blueControl.isOn ? 1 : 0;
                
        colorView.backgroundColor = UIColor(red:r, green:g, blue:b, alpha:1);
    }
}


