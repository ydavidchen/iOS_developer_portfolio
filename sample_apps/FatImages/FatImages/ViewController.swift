//  ViewController.swift
//  FatImages
//  Created by Fernando Rodriguez on 10/12/15.
//  Copyright © 2015 Udacity. All rights reserved.
// Name ends in "VIEW", it must be in main "QUEUE" (with exception, of course)

import UIKit;

// MARK: - BigImages: String
enum BigImages: String {
    case whale = "https://d17h27t6h515a5.cloudfront.net/topher/2017/November/59fe5127_whale/whale.jpg";
    case shark = "https://d17h27t6h515a5.cloudfront.net/topher/2017/November/59fe5123_shark/shark.jpg";
    case seaLion = "https://d17h27t6h515a5.cloudfront.net/topher/2017/November/59fe511f_sealion/sealion.jpg";
}

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    // MARK: Actions
    @IBAction func setTransparencyOfImage(sender: UISlider) {
        photoView.alpha = CGFloat(sender.value);
    }
    
    // MARK: - Sync-Download a huge image, block the main queue & UI
    @IBAction func synchronousDownload(sender: UIBarButtonItem) {
        activityView.startAnimating();
        
        if let url = URL(string: BigImages.seaLion.rawValue) {
            let imgData = try? Data(contentsOf: url);
            let image = UIImage(data:imgData!);
            self.photoView.image = image;
            self.activityView.stopAnimating();
        }
    }
    
    // MARK: - Async Download to avoid blocking by creating a background queue without blocking UI
    @IBAction func simpleAsynchronousDownload(sender: UIBarButtonItem) {
        let url = URL(string: BigImages.shark.rawValue)!;
        let download = DispatchQueue(__label: "download", attr: nil); //main thread
        download.async{ () -> Void in
            let imgData = try? Data(contentsOf: url);
            let image = UIImage(data:imgData!);
            DispatchQueue.main.async(execute: {() -> Void in
                self.photoView.image = image;
            });
        }
        
    }
    
    // MARK: - Async Download (with Completion Handler)
    @IBAction func asynchronousDownload(sender: UIBarButtonItem) {
    }
}
