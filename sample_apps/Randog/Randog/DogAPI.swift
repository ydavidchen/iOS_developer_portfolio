//  DogAPI.swift
//  Randog w/ MVC Architecture
//  Created by DavidKevinChen on 4/10/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;

class DogAPI {
    //MARK: - Each case is an endpoint
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random";
        
        //Computed property:
        var url: URL {
            return URL(string:self.rawValue)!; //unwrapping required
        }
    }
}
