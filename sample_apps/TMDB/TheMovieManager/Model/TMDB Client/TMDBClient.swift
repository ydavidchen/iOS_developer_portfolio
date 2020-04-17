//  TMDBClient.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import Foundation;

class TMDBClient {
    //MARK: - Authentication object
    struct Auth {
        static var accountId = 0;
        static var requestToken = "";
        static var sessionId = "";
    }
    
    // MARK: - Endpoints that rotatingly return URLs
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3";
        static let apiKeyParam = "?api_key=\(APIKEY.apiKey)"; //construct API key into required format
        
        // Cases:
        case getWatchlist;
        case getRequestToken;
        case login;
        case createSessionId;
        case webAuth;
        case logout;

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
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to=themoviemanager:authenticate"; //see doc
            case .logout:
                return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam;
            }
        }
        
        // Universal URL property (computed property):
        var url: URL {
            return URL(string: stringValue)!;
        }
    }
    
    
    /*
     MARK: - Class functions matching the Endpoint cases
     */
    class func getWatchlist(completion: @escaping ([Movie],Error?) -> Void) { //GET 1/1; given by Udacity as example
        taskForGETRequest(url: Endpoints.getWatchlist.url, response: MovieResults.self) { (response,error) in
            if let response = response {
                completion(response.results, nil);
            } else {
                completion([], error); //empty array
            }
        }
    }
    
    class func getRequestToken(completion: @escaping (Bool,Error?) -> Void) { //GET 2/2
        taskForGETRequest(url: Endpoints.getRequestToken.url, response: RequestTokenResponse.self){ (response,error) in
            if let response = response {
                Auth.requestToken = response.requestToken;
                completion(true, nil);
            } else {
                completion(false, error);
            }
         }
    }
    
    class func login(username:String, password:String, completion: @escaping (Bool,Error?) -> Void) { //POST 1/2
        // Input params same as getRequestToken, plus username + password
        var request = URLRequest(url:Endpoints.login.url);
        request.httpMethod = "POST"; //Default is GET, and we override
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
    
    class func createSessionId(completion: @escaping (Bool,Error?) -> Void) { //POST 2/2
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
    
    class func logout(completion: @escaping () -> Void) { //for logging out: nothing is to be passed back
        var request = URLRequest(url:Endpoints.logout.url);
        request.httpMethod = "DELETE";
        request.addValue("application/json", forHTTPHeaderField:"Content-Type"); // UNSURE
        
        let body = LogoutRequest(sessionId: Auth.sessionId);
        request.httpBody = try! JSONEncoder().encode(body);
        
        let task = URLSession.shared.dataTask(with:request) {(data,response,error) in
            Auth.requestToken = "";
            Auth.sessionId = "" ;
            completion();
        }
        task.resume();
    }
    
    
    /*
     MARK: - Helper functions for re-factoring class-method code
     */
    class func taskForGETRequest<ResponseType:Decodable>(url:URL, response:ResponseType.Type, completion: @escaping (ResponseType?,Error?) -> Void) { //makes use of Swift Generics; NOTE SYNTAX!!!
        let task = URLSession.shared.dataTask(with:url) { (data,response,error) in
            // Get data:
            guard let data = data else {
                completion(nil, error);
                return;
            }
            
            // Handle data received via parsing on Main Thread
            let decoder = JSONDecoder();
            do {
                let responseObject = try decoder.decode(ResponseType.self, from:data); //Decodes into Generics
                DispatchQueue.main.async {
                    completion(responseObject, nil);
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error);
                }
            }
        }
        task.resume();
    }
    
}
