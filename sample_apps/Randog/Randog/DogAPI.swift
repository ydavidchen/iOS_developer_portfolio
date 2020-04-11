//  DogAPI.swift
//  Randog w/ MVC Architecture
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;
import UIKit;

class DogAPI {
    enum REUSE {
        case DEBUG, ERROR, INFO;
        var msg: String {
            switch self {
            case .DEBUG:
                return "DEBUG: ";
            case .ERROR:
                return "ERROR: ";
            case .INFO:
                return "INFO: ";
            }
        }
    }
    
    //MARK: - Each case is an endpoint (NOTE SYNTAX)
    enum Endpoint {
        case randomImageFromAllDogsCollection;
        case randomImageForBreed(String);
        case listAllBreeds;
        
        var url: URL {
            return URL(string:self.stringValue)!;
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random";
            case .randomImageForBreed(let breed):
                    return "https://dog.ceo/api/breeds/\(breed)/image/random";
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all";
            }
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
    
    class func requestBreedsList(completionHandler:@escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with:Endpoint.listAllBreeds.url) {(data, response, error) in
            // Retrieve data:
            guard let data = data else {
                completionHandler([], error)
                return;
            }
            
            /* Parse the JSON:
                 Note the decoder procedure CAN also be handled via do-catch, not just via try!
              */
            let decoder = JSONDecoder();
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from:data); //arg1=target data type, arg2=input
            let breeds = breedsResponse.message.keys.map({$0});//NOTE SYNTAX
            completionHandler(breeds, nil);
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
