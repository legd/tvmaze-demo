//
//  TVShowRequest.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 1/11/21.
//

import Foundation
import SwiftyJSON

class TVShowRequest {
    static let apiService = NAPIService<ShowRouter>()
    
    static func getAllShows(whileLoading: @escaping () -> Void, whenLoaded: @escaping () -> Void, onError: @escaping (String, [Int: Double]?) -> Void) {
        whileLoading()
        let _ = apiService.request(.allShows) { (data, error) in
            if let shows = data {

                for show in shows.array! {
                    TVMazeShows.sharedInstance.showList.append(TVShow(withJSON: show))
                }
                
                whenLoaded()
            } else if let _error = error {
                onError(_error.localizedDescription, nil)
            }
        }
    }
    
    static func updateShows(whileLoading: @escaping () -> Void, whenLoaded: @escaping () -> Void, onError: @escaping (String, [Int: Double]?) -> Void) {
        whileLoading()
        let _ = apiService.request(.showPage) { (data, error) in
            if let shows = data {

                for show in shows.array! {
                    TVMazeShows.sharedInstance.showList.append(TVShow(withJSON: show))
                }
                
                whenLoaded()
            } else if let _error = error {
                onError(_error.localizedDescription, nil)
            }
        }
    }
    
    static func searchShow(query: String, whileLoading: @escaping () -> Void, whenLoaded: @escaping () -> Void, onError: @escaping (String, [Int: Double]?) -> Void) {
        whileLoading()
        let _ = apiService.request(.search(query: query)) { (data, error) in
            if let shows = data {

                TVMazeShows.sharedInstance.showList.removeAll()
                for show in shows.array! {
                    TVMazeShows.sharedInstance.showList.append(TVShow(withJSON: show["show"]))
                }
                
                whenLoaded()
            } else if let _error = error {
                onError(_error.localizedDescription, nil)
            }
        }
    }
    
}
