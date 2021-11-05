//
//  FavoriteShow.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 4/11/21.
//

import Foundation
import RealmSwift

/// Model for the data base object representing a favorite show
class FavoriteShow: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var url = ""
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var language = ""
    @objc dynamic var genres = ""
    @objc dynamic var status = ""
    @objc dynamic var runtime = 0
    @objc dynamic var averageRuntime = 0
    @objc dynamic var premiered = ""
    @objc dynamic var ended = ""
    @objc dynamic var officialSite = ""
    @objc dynamic var schedule = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var weight = 0
    @objc dynamic var image = ""
    @objc dynamic var summary = ""
    @objc dynamic var updated = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getShowAsGeneric() -> ShowGeneric {
        return ShowGeneric(id: self.id,
                           name: self.name,
                           poster: self.image,
                           genres: self.genres,
                           summary: self.summary,
                           schedule: self.schedule,
                           isFavorite: true)
    }
    
}
