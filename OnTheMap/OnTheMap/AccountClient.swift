//  AccountClient.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;

class AccountClient {
    static let apiKey = "YOUR_TMDB_API_KEY";
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(AccountClient.apiKey)"
        
        case getRequestToken;
        case login;
        case webAuth;
        case logout;
        
        var stringValue: String {
            switch self {
            case .getRequestToken:
                return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
            case .login:
                return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
            case .logout:
                return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/\(Auth.requestToken)?redirect_to=themoviemanager:authenticate"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func logout(completion: @escaping () -> Void) {
        var request = URLRequest(url: Endpoints.logout.url);
        request.httpMethod = "DELETE";
        let body = LogoutRequest(sessionId: Auth.sessionId);
        request.httpBody = try! JSONEncoder().encode(body);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            Auth.requestToken = "";
            Auth.sessionId = "";
            completion();
        }
        task.resume();
    }
}
