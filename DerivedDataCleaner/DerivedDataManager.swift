//
//  DerivedDataManger.swift
//  DerivedDataCleaner
//
//  Created by jambo on 11/14/24.
//

import Foundation

class DerivedDataManager {
    static let shared = DerivedDataManager()
    
    private let derivedDataPath: String = {
        let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
        return homeDirectory.appendingPathComponent("Library/Developer/Xcode/DerivedData").path
    }()
    
    func clearDerivedData() -> (success: Bool, message: String) {
        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(atPath: derivedDataPath)
            
            for item in contents {
                let itemPath = (derivedDataPath as NSString).appendingPathComponent(item)
                try fileManager.removeItem(atPath: itemPath)
            }
            
            return (true, "Successfully cleared DerivedData")
        } catch {
            return (false, "Failed to clear DerivedData")
        }
    }
}
