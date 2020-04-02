//  StoryNode.swift
//  MYOA Custom Object Class
//  Copyright (c) 2015 Udacity. All rights reserved.

struct StoryNode {
    //MARK: - Fields & constructor
    var message: String;
    private var adventure: Adventure;
    private var connections: [Connection];
    var imageName: String? {
        return adventure.credits.imageName;
    }
    
    init(dictionary: [String:AnyObject], adventure: Adventure) {
        self.adventure = adventure;
        message = dictionary["message"] as! String;
        connections = [Connection]();
        message = message.replacingOccurrences(of: "\\n", with: "\n\n");
        if let connectionsArray = dictionary["connections"] as? [[String : String]] {
            for connectionDictionary: [String : String] in connectionsArray {
                connections.append(Connection(dictionary: connectionDictionary))
            }
        }
    }
    
    //MARK: - Prompt custom methods
    func promptCount() -> Int {
        // The number of prompts for story choices
        return connections.count
    }
    
    func promptForIndex(_ index: Int) -> String {
        return connections[index].prompt;
    }
    
    func storyNodeForIndex(index: Int) -> StoryNode {
        // StoryNode that corresponds to the prompt with the same index
        let storyNodeName = connections[index].connectedStoryNodeName;
        let storyNode = adventure.storyNodes[storyNodeName];
        return storyNode!;
    }
}
