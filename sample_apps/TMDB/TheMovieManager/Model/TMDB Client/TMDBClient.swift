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
        
        // Cases for basic features
        case getWatchlist;
        case getFavourites;
        case getRequestToken;
        case login;
        case createSessionId;
        case webAuth;
        case logout;
        
        // Cases for advanced features:
        case search(String); //associated value for search term
        case addToWatchlist; //successful status codes: 1, 12, 13 - see doc
        
        // Associated values:
        var stringValue: String {
            switch self {
            // Basic enum cases
            case .getWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)";
            case .getFavourites:
                return Endpoints.base + "/account/\(Auth.accountId)/favorite/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)";
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
            
            // Enum cases for advanced features:
            case .search(let query): //note syntax; TODO: implement space handlinge
                return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")";
            case .addToWatchlist:
                return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam;
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
    // MARK: - Basic functionalities
    class func getWatchlist(completion: @escaping ([Movie],Error?) -> Void) { //GET 1/1
        taskForGETRequest(url:Endpoints.getWatchlist.url, responseType:MovieResults.self) {(response,error) in
            if let response = response {
                completion(response.results, nil);
            } else {
                completion([], error); //return empty array if request error
            }
        }
    }
    
    class func getFavourites(completion: @escaping ([Movie],Error?) -> Void) { // VERY similar to getWatchList
        taskForGETRequest(url:Endpoints.getFavourites.url, responseType:MovieResults.self) {(response,error) in
            if let response = response {
                completion(response.results, nil);
            } else {
                completion([], error);
            }
        }
    }
    
    class func getRequestToken(completion: @escaping (Bool,Error?) -> Void) { //GET 2/2
        taskForGETRequest(url: Endpoints.getRequestToken.url, responseType:RequestTokenResponse.self){ (response,error) in
            if let response = response {
                Auth.requestToken = response.requestToken;
                completion(true, nil);
            } else {
                completion(false, error); //return FALSE if request error
            }
         }
    }
    
    class func login(username:String, password:String, completion: @escaping (Bool,Error?) -> Void) { //POST 1/2
        let body = LoginRequest(username:username, password:password, requestToken:Auth.requestToken);
        taskForPOSTRequest(url:TMDBClient.Endpoints.login.url, responseType:RequestTokenResponse.self, body:body) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken;
                completion(true, nil);
                return
            } else {
                completion(false, error);
            }
        }
    }
    
    class func createSessionId(completion: @escaping (Bool,Error?) -> Void) { //POST 2/2
        let body = PostSession(requestToken:Auth.requestToken); //TODO: Updated
        taskForPOSTRequest(url:Endpoints.createSessionId.url, responseType:SessionResponse.self, body:body) {(response, error) in
            if let response = response {
                Auth.sessionId = response.sessionId; //TODO: Updated
                completion(true, nil);
                return
            } else {
                completion(false, error);
            }
        }
    }
    
    class func logout(completion: @escaping () -> Void) {
        let body = LogoutRequest(sessionId: Auth.sessionId);
        taskForDELETERequest(url:Endpoints.logout.url, responseType:LogoutRequest.self, body:body) {() in
            completion();
        }
    }
    
    // MARK: - Advanced functionalities
    class func search(query:String, completion: @escaping ([Movie],Error?) -> Void) {
        // Called in SearchViewController.swift
        taskForGETRequest(url:Endpoints.search(query).url, responseType:MovieResults.self) {(response,error) in
            if let response = response {
                completion(response.results, nil);
            } else {
                completion([], error);
            }
        }
    }
    
    class func markWatchlist(movieId:Int, watchlist:Bool, completion: @escaping (Bool,Error?) -> Void) {
        // Called in **MovieDetailViewController**, NOT WatchlistViewController.swift
        // Make POST request & parse into generic TMDBResponse
        let body = MarkWatchlist(mediaType:"movie", mediaId:movieId, watchlist:watchlist);
        
        taskForPOSTRequest(url:Endpoints.addToWatchlist.url, responseType:TMDBResponse.self, body:body) {(response,error) in
            if let response = response {
                let compositeStatus = response.statusCode==1 || response.statusCode==13;
                completion(compositeStatus, nil); //if parsing succeeds
                print("DEBUG: Status returned = " + String(response.statusCode));
            } else {
                print("ERROR: Failed to finish running markWatchlist()!");
                completion(false, error);
            }
        }
    }
    
    
    /*
     MARK: - Reusable helper functions for re-factoring class-method code, for both basic & advanced functionalities
     */
    class func taskForGETRequest<ResponseType:Decodable>(url:URL, responseType:ResponseType.Type, completion: @escaping (ResponseType?,Error?) -> Void) { //makes use of Swift Generics; NOTE SYNTAX!!!
        let task = URLSession.shared.dataTask(with:url) {(data,response,error) in
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
    
    class func taskForPOSTRequest<RequestType:Encodable, ResponseType:Decodable>(url:URL, responseType:ResponseType.Type, body:RequestType, completion: @escaping (ResponseType?,Error?) -> Void) {
        var request = URLRequest(url:url);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        request.httpBody = try! JSONEncoder().encode(body);
        
        let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error);
                }
                return;
            }

            do {
                let decoder = JSONDecoder();
                let responseObject = try decoder.decode(ResponseType.self, from:data);
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
    
    class func taskForDELETERequest<RequestType:Encodable, ResponseType:Decodable>(url:URL, responseType:ResponseType.Type, body:RequestType, completion:@escaping () -> Void) {
        var request = URLRequest(url:url);
        request.httpMethod = "DELETE";
        request.addValue("application/json", forHTTPHeaderField:"Content-Type"); // UNSURE
        request.httpBody = try! JSONEncoder().encode(body);
        
        let task = URLSession.shared.dataTask(with:request) {(data,response,error) in
            DispatchQueue.main.async {
                Auth.requestToken = "";
                Auth.sessionId = "" ;
                completion();
            }
        }
        task.resume();
    }
}
