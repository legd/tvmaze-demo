//
//  TVShow.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 1/11/21.
//

import Foundation
import SwiftyJSON

final class TVShow {
    
    var id = 0
    var url = ""
    var name = ""
    var type = ""
    var language = ""
    var genres:[String] = Array()
    var status = ""
    var runtime = 0
    var averageRuntime = 0
    var premiered = ""
    var ended = ""
    var officialSite = ""
    var schedule: Schedule!
    var rating = 0.0
    var weight = 0
    var image: Image
    var summary = ""
    var updated = 0
    var genresJoined: String {
        return genres.joined(separator: "・")
    }
    
    var scheduleJoined: String {
        return schedule.days.joined(separator: "・")
    }
    
    init(withJSON json: JSON) {
        id = json["id"].intValue
        url = json["url"].stringValue
        name = json["name"].stringValue
        type = json["type"].stringValue
        language = json["language"].stringValue
        genres = json["genres"].arrayObject as! [String]
        status = json["status"].stringValue
        runtime = json["runtime"].intValue
        averageRuntime = json["averageRuntime"].intValue
        premiered = json["premiered"].stringValue
        ended = json["ended"].stringValue
        officialSite = json["officialSite"].stringValue
        schedule = Schedule(withJSON: json["schedule"])
        rating = json["rating"]["average"].doubleValue
        weight = json["weight"].intValue
        image = Image(withJSON: json["image"])
        summary = json["summary"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        updated = json["updated"].intValue
    }
    
    func getShowAsGeneric() -> ShowGeneric {
        return ShowGeneric(id: self.id,
                           name: self.name,
                           poster: self.image.original,
                           genres: self.genresJoined,
                           summary: self.summary,
                           schedule: self.scheduleJoined,
                           isFavorite: false)
    }
    
    func toDBModel() -> FavoriteShow {
        let dbModel = FavoriteShow()
        dbModel.id = self.id
        dbModel.url = self.url
        dbModel.name = self.name
        dbModel.type = self.type
        dbModel.language = self.language
        dbModel.genres = self.genresJoined
        dbModel.status = self.status
        dbModel.runtime = self.runtime
        dbModel.averageRuntime = self.averageRuntime
        dbModel.premiered = self.premiered
        dbModel.ended = self.ended
        dbModel.officialSite = self.officialSite
        dbModel.schedule = self.scheduleJoined
        dbModel.rating = self.rating
        dbModel.weight = self.weight
        dbModel.image = self.image.original
        dbModel.summary = self.summary
        dbModel.updated = self.updated
        return dbModel
    }
}

extension TVShow: Hashable, Codable {
    
    static func == (lhs: TVShow, rhs: TVShow) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
