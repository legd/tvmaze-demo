//
//  DBManager.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 4/11/21.
//

import Foundation
import RealmSwift

class DBManager {
    private let realm = try! Realm()
    static let shared = DBManager()
    
    private init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    // MARK: - Add function
    /**
        Function to add a new TV show
     */
    func add(newShow show: FavoriteShow) {
        try! realm.write {
            realm.add(show, update: .all)
        }
    }
    
    // MARK: - Get all show function
    /**
        Function to get all TV shows in the database
     */
    func getAllShows() -> Results<FavoriteShow> {
        return realm.objects(FavoriteShow.self)
    }
    
    // MARK: - Delete function
    /**
        Function to delete a show from the database
     */
    func deleteThis(show showToDelete: FavoriteShow) {
        try! realm.write {
            realm.delete(showToDelete)
        }
    }
    
    /**
        Function to delete a show from the database
     */
    func deleteThis(id: Int) {
        try! realm.write {
            realm.delete(realm.object(ofType: FavoriteShow.self, forPrimaryKey: id)!);
        }
    }
}
