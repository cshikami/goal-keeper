//
//  Checkmarks.swift
//  ShikamiC_FinalProject
//
//  Created by Christopher Shikami on 3/11/17.
//  Copyright © 2017 Chris. All rights reserved.
//

import Foundation

class CheckmarkItem: NSObject, NSCoding
{
    var done: Bool

public init(done: Bool)
{
    self.done = false
}
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder.containsValue(forKey: "done")
        {
            self.done = aDecoder.decodeBool(forKey: "done")
        }
        else {
            return nil
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.done, forKey: "done")
    }
}

extension Collection where Iterator.Element == CheckmarkItem {
    //Builds the persistence URL. This is a location inside
    // the "Application Support" directory for the App
    private static func persistencePath() -> URL?
    {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("checkmarkitem.bin")
    }
    
    //Write the array to persistence
    func writeToPersistence() throws
    {
        if let url = Self.persistencePath(), let array = self as? NSArray
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: array)
            try data.write(to: url)
        }
        else
        {
            throw NSError(domain: "com.example.Checkmarks", code: 10, userInfo: nil)
        }
    }
    
    //Read the array from persistence
    static func readFromPersistence() throws -> [CheckmarkItem]
    {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?)
        {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CheckmarkItem]
            {
                return array
            }
            else
            {
                throw NSError(domain: "com.example.Checkmarks", code: 11, userInfo: nil)
            }
        }
        else
        {
            throw NSError(domain: "com.example.Checkmarks", code: 12, userInfo: nil)
        }
    }
}
