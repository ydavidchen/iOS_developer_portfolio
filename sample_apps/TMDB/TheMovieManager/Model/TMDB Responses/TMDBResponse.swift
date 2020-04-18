//  TMDBResponse.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
// See bottom of: developers.themoviedb.org/3/account/add-to-watchlist

import Foundation;

struct TMDBResponse: Codable {
    let statusCode: Int;
    let statusMessage: String;
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code";
        case statusMessage = "status_message";
    }
}
