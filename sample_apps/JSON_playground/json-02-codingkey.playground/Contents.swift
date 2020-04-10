// JSON Exercise: Coding Keys
// Udacity

import Foundation;

// Given example:
var json = """
{
    "food_name": "Lemon",
    "taste": "sour",
    "number of calories": 17
}
""".data(using: .utf8)!

// Parse:
struct Food: Codable {
    let name: String
    let taste: String
    let calories: Int
    
    //TODO: Add CodingKeys enum here
    enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case taste = "taste"
        case calories = "number of calories"
    }
}

// Test case:
let decoder = JSONDecoder();
let food: Food;
do {
    food = try decoder.decode(Food.self, from: json);
    print(food);
} catch {
    print(error); 
}
