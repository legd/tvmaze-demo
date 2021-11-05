//
//  Episode.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import Foundation
import SwiftyJSON

final class Episode {
    
    var id = 0
    var url = ""
    var name = ""
    var season = 0
    var number = 0
    var type = ""
    var airdate = ""
    var airtime = ""
    var airstamp = ""
    var runtime = 0
    var rating = 0.0
    var image: Image
    var summary = ""
          
    init(withJSON json: JSON) {
        id = json["id"].intValue
        url = json["url"].stringValue
        name = json["name"].stringValue
        season = json["season"].intValue
        number = json["number"].intValue
        type = json["type"].stringValue
        airdate = json["airdate"].stringValue
        airtime = json["airtime"].stringValue
        airstamp = json["airstamp"].stringValue
        runtime = json["runtime"].intValue
        rating = json["rating"]["average"].doubleValue
        image = Image(withJSON: json["image"])
        summary = json["summary"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
