//
//  Image.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 2/11/21.
//

import Foundation
import SwiftyJSON

final class Image {
    
    var medium = ""
    var original = ""
    
    init(withJSON json: JSON) {
        medium = json["medium"].stringValue
        original = json["original"].stringValue
    }
}

extension Image: Hashable, Codable {
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.medium == rhs.medium
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(original)
    }
}
