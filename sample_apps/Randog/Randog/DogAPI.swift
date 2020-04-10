//  DogAPI.swift
//  Randog w/ MVC Architecture
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

class DogAPI {
    //MARK: - Each case is an endpoint
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random";
        
        //Computed property:
        var url: URL {
            return URL(string:self.rawValue)!; //unwrapping required
        }
    }
    
    //MARK: - Request random image
    class func requestRandomImage(completionHandler: @escaping (DogImage?, Error?) -> Void) {

        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url;
        print(randomImageEndpoint);
        
        let task = URLSession.shared.dataTask(with:randomImageEndpoint){(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error);
                return;
            }
            print(data);

            let decoder = JSONDecoder();
            let imageData = try! decoder.decode(DogImage.self, from:data);
                   print(imageData);
            completionHandler(imageData, nil);
        }
        task.resume();
        
    }
    
    //MARK: - API request procedures
    class func requestImageFile(imageUrl:URL, completionHandler: @escaping (UIImage?,Error?) -> Void) {
        let task = URLSession.shared.dataTask(with:imageUrl, completionHandler: {(data, response, error) in
            
            // Scenario 1: Error!=nil && Image=nil
            guard let data = data else {
                print("Failed to fetch data from API");
                completionHandler(nil, error);
                return;
            }
            
            // Scenario 2: Image!=nil WHEN Error=nil
            let downloadedImg = UIImage(data:data); //overloaded constructor
            completionHandler(downloadedImg, nil);
        });
        
        task.resume();
    }
    
}
