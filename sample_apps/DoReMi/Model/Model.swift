//
//  Model.swift
//  DoReMi
//
//  Created by DavidKevinChen on 3/30/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation;

class Model {
    // MARK: - Properties
    var id: [String];
    var detail: [String];
    var count: Int;
    
    // MARK: - Constructor, getter & setter
    init(_ id: [String], _ detail: [String]) {
        self.id = id;
        self.detail = detail;
        self.count = id.count; //computed property
    }
    
    func getId(index: Int) -> String {
        return self.id[index];
    }
    
    func getDetail(index: Int) -> String {
        return "Detail: " + self.detail[index];
    }
}
