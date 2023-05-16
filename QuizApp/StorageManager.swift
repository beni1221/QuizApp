//
//  StorageManager.swift
//  QuizApp
//
//  Created by Arben on 5.5.23.
//

import UIKit

class StorageManager: NSObject {
    private static let defaults = UserDefaults.standard

    static func saveHeighestValue(value: Int) {
        defaults.setValue(value, forKey: "highestScore")
    }
    
    static func getHeighestValue() -> Int? {
        defaults.value(forKey: "highestScore") as? Int
    }
}
