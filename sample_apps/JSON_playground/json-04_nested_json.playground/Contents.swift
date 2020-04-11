import Foundation;

// Problem given:
var json = """
{
    "name": "Neha",
    "studentId": 326156,
    "academics": {
        "field": "iOS",
        "grade": "A"
    }
}
""".data(using: .utf8)!

// TODO: define model objects here
struct Academics: Codable {
    let field: String;
    let grade: String;
}
struct Student: Codable {
    let name: String;
    let studentId: Int;
    let academics: Academics; //subfield
}

// Test case:
let decoder = JSONDecoder();
let student: Student;

do {
    // TODO: decode the JSON into the "student" constant
    student = try decoder.decode(Student.self, from:json);
    print(student)
} catch {
    print(error)
}

// Extras: Access keys & values directly

