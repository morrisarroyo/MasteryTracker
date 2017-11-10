//
//  Utility.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-24.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class Utility: NSObject {
    class func getPath(fileName: String) -> String {
        
        let documentsURL = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        print(fileURL.path)
        return fileURL.path
    }
    
    class func copyDatabase() {
        let fileManager = FileManager.default
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let destinationPath = path.appendingPathComponent("db.sqlite3")
        //print(path)
        let sourcePath = Bundle.main.path(forResource: "db", ofType: "sqlite3", inDirectory: "Data")
        //print(sourcePath!)
        do {
            try fileManager.copyItem(atPath: sourcePath!, toPath: destinationPath)
        } catch {
            print ("Couldn't copy ds.sqlite3 to application documents")
        }
    }
}
