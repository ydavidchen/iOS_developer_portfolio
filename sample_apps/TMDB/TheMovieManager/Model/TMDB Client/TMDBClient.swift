//  TMDBClient.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import Foundation;

class TMDBClient {
    struct Auth {
        static var accountId = 0;
        static var requestToken = "";
        static var sessionId = "";
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3";
        static let apiKeyParam = "?api_key=\(APIKEY.apiKey)"; //construct API key into required format
        
        // Cases:
        case getWatchlist;
        case getRequestToken;
        case login;
        case createSessionId;

        // Alternation via associated values:
        var stringValue: String {
            switch self {
            case .getWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)";
            case .getRequestToken:
                return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam;
            case .login:
                return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam;
            case .createSessionId:
                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam;
            }
        }
        
        // Universal URL property (computed property):
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
                completion([], error);
                return
            }
            let decoder = JSONDecoder();
            do {
                let responseObject = try decoder.decode(MovieResults.self, from:data);
                completion(responseObject.results, nil);
            } catch {
                completion([], error);
            }
        }
        task.resume();
    }
    
    class func getRequestToken(completion: @escaping (Bool,Error?) -> Void) {
        // Very similar to getWatchList() with few exceptions
        // Returns: tuple of Bool indicating success AND optional error
        let task = URLSession.shared.dataTask(with: Endpoints.getRequestToken.url) {(data,response,error) in
            guard let data = data else {
                print("ERROR: Failed to retrieve request token");
                completion(false, error);
                return;
            }
            
            let decoder = JSONDecoder();
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from:data);
                Auth.requestToken = responseObject.requestToken;
                completion(true, nil);
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
    class func login(username:String, password:String, completion: @escaping (Bool,Error?) -> Void) {
        // Input params same as getRequestToken, plus username + password
        var request = URLRequest(url:Endpoints.login.url);
        request.httpMethod = "POST"; //Update: note default is GET, and we override
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        let body = LoginRequest(username:username, password:password, requestToken:Auth.requestToken);
        request.httpBody = try! JSONEncoder().encode(body);
        
        // Task via trail-enclosure syntax:
        let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
            guard let data = data else {
                print("ERROR: Failed to login()");
                completion(false, error);
                return;
            }
            
            // Catch response, or error if fails:
            do {
                let decoder = JSONDecoder();
                let responseObject = try decoder.decode(RequestTokenResponse.self, from:data);
                print("DEBUG: Auth.requestToken in TMDBClicne.login(): " + Auth.requestToken);
                Auth.requestToken = responseObject.requestToken;
                completion(true, nil);
            } catch {
                print("ERROR: Failed to invoke TMDBClient.login()!");
                completion(false, error);
            }
        }
        task.resume();
    }
    
    class func createSessionId(completion: @escaping (Bool,Error?) -> Void) {
        var request = URLRequest(url:Endpoints.createSessionId.url);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        let body = PostSession(requestToken:Auth.requestToken); //TODO: Updated
        request.httpBody = try! JSONEncoder().encode(body);
        
        let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
            guard let data = data else {
                print("ERROR: Failed to request session ID");
                completion(false, error);
                return;
            }
            
            do {
                let decoder = JSONDecoder();
                let responseObject = try decoder.decode(SessionResponse.self, from:data); //TODO: Updated
                Auth.sessionId = responseObject.sessionId; //TODO: Updated
                completion(true, nil);
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
}
