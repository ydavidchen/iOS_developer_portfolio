//  TMDBClient.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import Foundation

class TMDBClient {
    static let apiKey = "DUMMY_KEY";
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3";
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)";
        
        case getWatchlist;
        case getRequestToken;
        case login;
        case createSessionId;
        case webAuth;
        case logout;
        
        var stringValue: String {
            switch self {
            case .getWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)";
            case .getRequestToken:
                return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam;
            case .login:
                return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam;
            case .createSessionId:
                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam;
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redict_to=themoviemanager:authenticate";
            case .logout:
                 return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam;
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getRequestToken(completion: @escaping(Bool, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getWatchlist.url) { data, response, error in
            guard let data = data else {
                completion(false, error);
                return;
            }
            
            let decoder = JSONDecoder();
            do {
                let responseObject = try decoder.decode(RequestTokenResponse.self, from: data)
                completion(true, nil);
                
                Auth.requestToken = responseObject.requestToken;
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
    
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
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
        task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping(Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.login.url);
        request.httpMethod = "POST"; //needed b/c default is GET
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        let body = LoginRequest(username:username, password:password, requestToken:Auth.requestToken);
        request.httpBody = try! JSONEncoder().encode(body); //try! required for disabling error propagation
        
        let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
            // Retrieve data with guard let & early exit
            guard let data = data else {
                completion(false, error);
                return;
            }
            
            // Handle data received via do-catch:
            do {
                let decoder = JSONDecoder();
                let responseObject = try decoder.decode(RequestTokenResponse.self, from:data); //permits error propagation to catch block
                Auth.requestToken = responseObject.requestToken;
                completion(true, nil);
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
    
    class func createSessionId(completion: @escaping (Bool, Error?) -> Void) {
        // Logic of POST request in Create-Session works SAME as Login!!!
        var request = URLRequest(url: Endpoints.createSessionId.url);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        let body = PostSession(requestToken: Auth.requestToken);
        request.httpBody = try! JSONEncoder().encode(body); //try! required for disabling error propagation
        
        // Decoder task much similar to login() above:
        let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
            guard let data = data else {
                completion(false, error);
                return;
            }
        
            do {
                let decoder = JSONDecoder();
                let responseObject = try decoder.decode(SessionResponse.self, from:data); //permits error propagation to catch block
                Auth.sessionId = responseObject.sessionId;
                completion(true, nil);
            } catch {
                completion(false, error);
            }
        }
        task.resume();
    }
    
    class func logout(completion: @escaping () -> Void) {
        // Very much like POST request
        var request = URLRequest(url: Endpoints.createSessionId.url);
        request.httpMethod = "DELETE"; //distinction
        let body = LogoutRequest(requestToken:Auth.sessionId);
        request.httpBody = try! JSONEncoder().encode(body);
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            Auth.requestToken = "";
            Auth.sessionId = "";
            completion();
        }
        
        task.resume();
    }
}
