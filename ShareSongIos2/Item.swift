//
//  Item.swift
//  ShareSongIos2
//
//  Created by user935487 on 1/4/24.
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
