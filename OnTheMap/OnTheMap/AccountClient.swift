//  AccountClient.swift
//  OnTheMap
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import Foundation;

class AccountClient {
    static let apiKey = "Udacity_API_KEY"; //TODO
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        static let apiKeyParam = "?api_key=\(AccountClient.apiKey)"
        
        case login;
        case getUser;
        case logout;
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.base + "/session";
            case .getUser:
                return Endpoints.base + "/users/3903878747"; //TODO
            case .logout:
                return Endpoints.base + "/session";
            }
        }
        
        var url: URL {
            return URL(string:stringValue)!
        }
    }
    
    class func login(username:String, password:String, completion: @escaping (Bool,Error?) -> Void) {
        // Create POST request:
        var request = URLRequest(url:Endpoints.login.url);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField:"Accept");
        request.addValue("application/json", forHTTPHeaderField:"Content-Type");
        request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8);
     
        // Create Task:
        let task = URLSession.shared.dataTask(with:request) {
            (data,response,error) in
            if error != nil {
                return;
            }
            // let range = Range(5..<data!.count) //deprecated
            let range: CountableRange<Int> = 5..<data!.count; //force unwrap
            let newData = data?.subdata(in: range) //subset response data
            print(String(data:newData!, encoding:.utf8)!);
        }
        task.resume();
    }
    
    class func getUdacityUser(completion: @escaping () -> Void) {
        let request = URLRequest(url:Endpoints.getUser.url);
        let task = URLSession.shared.dataTask(with:request) { (data, response, error) in
          if error != nil {
            return;
          }
          let range: CountableRange<Int> = 5..<data!.count;
          let newData = data?.subdata(in:range) /* subset response data! */
          print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume();
    }
    
    class func logout(completion: @escaping () -> Void) {
        //Request
        var request = URLRequest(url:Endpoints.logout.url);
        request.httpMethod = "DELETE";
        var xsrfCookie: HTTPCookie? = nil;
        let sharedCookieStorage = HTTPCookieStorage.shared;
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie;
            } else {
                print("Failed to handle XSRF");
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField:"X-XSRF-TOKEN");
        }
        
        // Task
        let task = URLSession.shared.dataTask(with:request) { (data,response,error) in
          if error != nil {
            return;
          }
          let range: CountableRange<Int> = 5..<data!.count;
            let newData = data?.subdata(in:range);
            print(String(data: newData!, encoding: .utf8)!);
        }
        task.resume();
    }
}
