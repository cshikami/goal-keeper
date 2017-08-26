//
//  Goal.swift
//  ShikamiC_FinalProject
//
//  Created by Christopher Shikami on 3/6/17.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation

var goals = [Goal]()
///Goal object to store text fields and deadline field
///Encode and decode textfield strings in order to save the state of the user input
class Goal: NSObject, NSCoding {
    
    var name: String
    var goalPoint1: String
    var goalPoint2: String
    var goalPoint3: String
    var deadline: String
    
    init(name: String, goalPoint1: String, goalPoint2: String, goalPoint3: String, deadline: String)
    {
        self.name = name
        self.goalPoint1 = goalPoint1
        self.goalPoint2 = goalPoint2
        self.goalPoint3 = goalPoint3
        self.deadline = deadline
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        }
        else {
            return nil
        }
        
        if let goalPoint1 = aDecoder.decodeObject(forKey: "goalPoint1") as? String {
            self.goalPoint1 = goalPoint1
        }
        else {
            return nil
        }
        
        if let goalPoint2 = aDecoder.decodeObject(forKey: "goalPoint2") as? String {
            self.goalPoint2 = goalPoint2
        }
        else {
            return nil
        }
        
        if let goalPoint3 = aDecoder.decodeObject(forKey: "goalPoint3") as? String {
            self.goalPoint3 = goalPoint3
        }
        else {
            return nil
        }
        
        if let deadline = aDecoder.decodeObject(forKey: "deadline") as? String {
            self.deadline = deadline
        }
        else {
            return nil
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.goalPoint1, forKey: "goalPoint1")
        aCoder.encode(self.goalPoint2, forKey: "goalPoint2")
        aCoder.encode(self.goalPoint3, forKey: "goalPoint3")
        aCoder.encode(self.deadline, forKey: "deadline")
    }
}


//Creates an extension of the Collection type (aka an Array),
//but only if it is an array of Goal objects
extension Collection where Iterator.Element == Goal
{
    //Builds the persistence URL. This is a location inside the
    //"Application Support" directory for the App.
    private static func persistencePath() -> URL?
    {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("goalitems.bin")
    }
    
    //Write the array to persistence
    func writeToPersistence() throws
    {
    if let url = Self.persistencePath(), let array = self as? NSArray
    {
    let data = NSKeyedArchiver.archivedData(withRootObject: array)
        try data.write(to: url)
    }
    else {
        throw NSError(domain: "com.example.Goal", code: 10 , userInfo: nil)
        }
    }
    
    //Read the array from persistence
    static func readFromPersistence() throws -> [Goal]
    {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?)
        {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Goal]
            {
                return array
            }
            else
            {
                throw NSError(domain: "com.example.Goal", code: 11, userInfo: nil)
            }
        }
        else
        {
            throw NSError(domain: "com.example.Goal", code: 12, userInfo: nil)
        }
    }
    
}

