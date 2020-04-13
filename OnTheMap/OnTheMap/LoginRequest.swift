//  LoginRequest.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/12/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation
struct LoginRequest: Codable {
    let udacity: [String];
    let username: String;
    let password: String;
    
    enum CodingKeys: String, CodingKey {
        case username;
        case password;
        case udacity;
    }
}

