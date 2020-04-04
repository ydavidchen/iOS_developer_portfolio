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
    var memes = [Meme]();

    //MARK: - Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.tabBar.isHidden = false; //keep TabBar on by on start
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //TODO: FlowLayout
    }
    
    //MARK: - CollectionView contract implementations
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(); //placeholder
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Optimize code by avoiding code duplication
        let sentMemeVC = self.storyboard?.instantiateViewController(identifier:Meme.ID_TABLE) as! ViewController;
        sentMemeVC.meme = Meme.getMeme(memes, indexPath);
        self.navigationController?.pushViewController(sentMemeVC, animated: true);
    }
}
