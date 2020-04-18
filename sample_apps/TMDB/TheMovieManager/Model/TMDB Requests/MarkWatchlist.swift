//  MarkWatchlist.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//  See doc at: developers.themoviedb.org/3/account/add-to-watchlist

import Foundation;

struct MarkWatchlist: Codable {
    let mediaType: String;
    let mediaId: Int; //see doc
    let watchlist: Bool;
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type";
        case mediaId = "media_id";
        case watchlist = "watchlist";
    }
}

