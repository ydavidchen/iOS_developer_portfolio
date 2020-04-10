//  ViewController.swift
//  Randog
//
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url;
        print(randomImageEndpoint);
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {(data, response, error) in
            
            // Closure -- code/fxn to run when complete
            guard let data = data else  {
                return;
            }
            print(data);
            
            //SERIALISATION approach: Parse retrieved JSON data - OLD school method
//            do {
//                let json = try JSONSerialization.jsonObject(with:data, options:[]) as! [String: Any];
//                let url = json["message"] as! String;
//                print(url);
//            } catch {
//                print(error);
//            }
            
            //CODABLE approach: Decode into custom type
            let decoder = JSONDecoder();
            let imageData = try! decoder.decode(DogImage.self, from:data);
            print(imageData);
            
            //Download image & set to imageview via Main thread in a NESTED TASK
            guard let imageUrl = URL(string: imageData.message) else {return;};
            
            let innerTask = URLSession.shared.dataTask(with:imageUrl, completionHandler: {(data, response, error) in
                
                guard let data = data else {
                    print("Failed to fetch data");
                    return;
                }
                let downloadedImg = UIImage(data:data); //overloaded constructor
                DispatchQueue.main.async {
                    self.imageView.image = downloadedImg;
                }
            });
            innerTask.resume();
            
        }
        
        
        task.resume();
    }


}

