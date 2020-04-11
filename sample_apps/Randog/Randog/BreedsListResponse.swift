//  BreedsListResponse.swift
//  Randog
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;

struct BreedsListResponse : Codable {
    let status: String;
    let message: [ String: [String] ];
}
