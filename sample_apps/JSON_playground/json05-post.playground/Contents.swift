//POST request exercise
//Starter Code & Instructions provided by Udacity

import Foundation;
import CoreFoundation;

/*
Complete code per instructions by Udacity
 */
// create a Codable struct called "POST" with the correct properties
struct Post: Codable {
    let userId: Int;
    let title: String;
    let body: String;
}

let BASE = "https://jsonplaceholder.typicode.com";
let encoder = JSONEncoder();

// create an instance of the Post struct with your own values
let myPost = Post(userId: 0, title:"udacity", body:"dummy");

// create a URLRequest by passing in the URL
var request = URLRequest(url:URL(string:BASE+"/posts")!);

// set the HTTP method to POST
request.httpMethod = "POST";

// set the HTTP body to the encoded "Post" struct
request.httpBody = try! encoder.encode(myPost);

// set the appropriate HTTP header fields
request.addValue("application/json", forHTTPHeaderField:"Content-Type");


/*
Test case
*/
// HACK: this line allows the workspace or an Xcode playground to execute the request, but is not needed in a real app
let runLoop = CFRunLoopGetCurrent();
// task for making the request
let task = URLSession.shared.dataTask(with:request) {(data, response, error) in
    print(String(data: data!, encoding: .utf8))
    CFRunLoopStop(runLoop)
}
task.resume();
// not necessary
CFRunLoopRun();
