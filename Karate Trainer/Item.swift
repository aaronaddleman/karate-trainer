//
//  Item.swift
//  Karate Trainer
//
//  Created by Aaron Addleman on 8/23/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
