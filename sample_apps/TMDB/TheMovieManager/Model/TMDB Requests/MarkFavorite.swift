//  MarkFavorite.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//  Doc: developers.themoviedb.org/3/account/mark-as-favorite

import Foundation;

struct MarkFavorite: Codable {
    let mediaId: Int;
    let mediaType: String;
    let favourite: Bool;
    
    enum CodingKeys: String, CodingKey {
        case mediaId = "media_id";
        case mediaType = "media_type";
        case favourite = "favorite";
    }
}
