//
//  Schedule.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 1/11/21.
//

import Foundation
import SwiftyJSON

final class Schedule {
    var time = ""
    var days: [String]
    
    init(withJSON json: JSON) {
        time = json["time"].stringValue
        days = json["days"].arrayObject as! [String]
    }
    
}

extension Schedule: Hashable, Codable {
    
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.time == rhs.time
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
}
