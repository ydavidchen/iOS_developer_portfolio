//  CollectionViewController.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

/**
Class methods should be consistent with TableViewController
*/
class CollectionViewController: UICollectionViewController {
    //MARK: - Properites & UI elements
    // var memes = Constants.getMemesFromAppDele();
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate;
        let appDelegate = object as! AppDelegate;
        return appDelegate.memes;
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!;
    let FL_SPACE: CGFloat = 3.0; //flowlayout

    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false; //keep TabBar on by on start
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //CollectionView FlowLayout:
        let dimension = (view.frame.size.width - 2*FL_SPACE) / 3.0;
        flowLayout.minimumInteritemSpacing = FL_SPACE;
        flowLayout.minimumLineSpacing = FL_SPACE;
        flowLayout.itemSize = CGSize(width:dimension, height:dimension);
    }
    
    //MARK: - Custom methods:
    @IBAction func addMeme(_ sender: Any) {
        Constants.triggerSentMemeVC(self.storyboard!, self.navigationController!);
    }
    
    //MARK: - CollectionView contract implementations
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = Constants.getMeme(memes, indexPath);
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell", for:indexPath) as! CollectionViewCell;
        cell.imageView.image = meme.memedImage;
        return cell;
    }
}
