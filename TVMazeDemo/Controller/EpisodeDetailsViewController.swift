//
//  EpisodeDetailsViewController.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var seasonAndNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    var episode: Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        poster.imageFromUrl(url: URL(string: episode.image.medium)!)
        seasonAndNumber.text = "S\(episode.season)E\(episode.number)"
        name.text = episode.name
        summary.text = episode.summary
    }
}
