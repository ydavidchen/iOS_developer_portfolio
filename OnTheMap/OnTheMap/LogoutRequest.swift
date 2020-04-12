//
//  LogoutRequest.swift
//  OnTheMap
//
//  Created by DavidKevinChen on 4/11/20.
//  Copyright © 2020 DavidKevinChen. All rights reserved.
//

import Foundation

struct LogoutRequest: Codable {
    let sessionId: String;
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id";
    }
}
