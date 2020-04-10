import Foundation;
var json = """
{
    "name": "Earth",
    "type": "rocky",
    "standardGravity": 9.81,
    "hoursInDay": 24
}
""".data(using: .utf8)!;

// Note syntax:
struct Planet: Codable{
    let name: String;
    let type: String;
    let standardGravity: Double;
    let hoursInDay: Int;
}

let decoder = JSONDecoder();
do {
    let earth = try decoder.decode(Planet.self, from:json);
    print(earth);
} catch {
    print(error);
}
