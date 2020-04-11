// JSON Array

import UIKit;
import Foundation;

//Given
var json = """
{
    "101": {
        "title": "Groundhog Day",
        "released": 1993,
        "starring": ["Bill Murray", "Andie MacDowell", "Chris Elliot"]
    },
    "102": {
        "title": "Home Alone",
        "released": 1990,
        "starring": ["Macaulay Culkin", "Joe Pesci", "Daniel Stern", "John Heard", "Catherine O'Hara"]
    }
}
""".data(using: .utf8)!

// Implementation
struct Movie: Codable {
    let title: String;
    let released: Int;
    let starring: [String];
}

let decoder = JSONDecoder();
var comedies: [String: Movie]; //note syntax
do {
    comedies = try decoder.decode([String: Movie].self, from: json); //decoded by using a [Type].selfm a type array
    print(comedies); // whole array, a dictionary
    
    // Parse out key-value pair:
    let comedyIds = comedies.keys.map({$0});
    print(comedyIds);
    
    let comedyNames = comedies.values.map({$0});
    print(comedyNames);
    
} catch {
    print(error)
}
