//  RequestTokenResponse.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import Foundation;
struct RequestTokenResponse: Codable {
    // See: https://developers.themoviedb.org/3/authentication/create-request-token
    let success: Bool;
    let expiresAt: String;
    let requestToken: String;
    
    enum CodingKeys: String, CodingKey {
        case success; //empty case; can specify as success="success"
        case expiresAt = "expires_at";
        case requestToken = "request_token";
    }
}
