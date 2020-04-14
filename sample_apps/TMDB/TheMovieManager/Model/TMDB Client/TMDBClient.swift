//
//  TMDBClient.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

class TMDBClient {
    // Under NO circumstance could API key be shared in public!!!
    static let apiKey = APIKEY.apiKey;
    
    //TODO: Figure out what this object does!!!
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"; //construct API key into required format
        
        // Cases:
        case getWatchlist;
        case getRequestToken;

        // Alternation via associated values
        var stringValue: String {
            switch self {
            case .getWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)";
            case .getRequestToken:
                return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam;
            }
        }
        
        // Universal URL property:
        var url: URL {
            return URL(string: stringValue)!;
        }
    }
    
    
    /*
     Class functions matching the Endpoint cases
     */
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) { //given
        let task = URLSession.shared.dataTask(with: Endpoints.getWatchlist.url) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(MovieResults.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume();
    }
    
    class func getRequestToken(completion: @escaping (Bool,Error?) -> Void) {
        // Very similar to getWatchList() with few exceptions
        // Returns: tuple of Bool indicating success AND optional error
        let task = URLSession.shared.dataTask(with: Endpoints.getRequestToken.url) { (data,response,error) in
            guard let data = data else {
                completion(false, error);
                return;
            }
            
            let decoder = JSONDecoder();
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from:data);
                Auth.requestToken = responseObject.requestToken; //Store requested token into Auth struct to be reused
                completion(true, nil); //if requestToken parsed & created & stored in Auth
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
}
