//
//  ShowDetailsViewController.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 2/11/21.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var schedule: UILabel!
    @IBOutlet weak var episodeListView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var show: ShowGeneric!
    var episodesList: [Episode] = Array()
    var seasonsAndEpisodes = [Int: [Episode]]()
    var delegate: FavoriteShowDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EpisodesRequest.getAllEpisodes(showId: show.id,
                                       whileLoading: {},
                                       whenLoaded: { episodeList in
                                            DispatchQueue.main.async {
                                                self.seasonsAndEpisodes = episodeList
                                                self.episodeListView.reloadData()
                                            }
                                       },
                                       onError: { message, data in
                                            print("Error con: \(message)")
                                     })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeListView.dataSource = self
        episodeListView.delegate = self
        episodeListView.register(EpisodeNameCell.nib(), forCellReuseIdentifier: "episodeRow")
    
        setUpView()
    }
    // teoria de conjunto teoria de probabilidad
    func setUpView() {
        poster.imageFromUrl(url: URL(string: show.poster)!)
        name.text = show.name
        genre.text = show.genres
        summary.text = show.summary
        schedule.text = show.schedule
        if show.isFavorite {
            favoriteButton.setImage(UIImage(named: "outline_favorite_white_48pt_1x"), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "episodeDetails" {
            let episodeDetails = segue.destination as! EpisodeDetailsViewController
            episodeDetails.episode = sender as? Episode
        }
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        if !show.isFavorite {
            let tvShow = TVMazeShows.sharedInstance.showList.filter { $0.id == show.id }
            
            if let newFavorite = tvShow.first {
                DBManager.shared.add(newShow: newFavorite.toDBModel())
                favoriteButton.setImage(UIImage(named: "outline_favorite_white_48pt_1x"), for: .normal)
                show.isFavorite = true
            }
        } else {
            DBManager.shared.deleteThis(id: self.show.id)
            favoriteButton.setImage(UIImage(named: "outline_favorite_border_white_48pt_1x"), for: .normal)
            show.isFavorite = false
            delegate.updateFavoriteShows()
        }
    }
}

// MARK: - UITableViewDataSource - UITableViewDelegate
extension ShowDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return seasonsAndEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasonsAndEpisodes[section + 1]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: "episodeRow", for: indexPath) as! EpisodeNameCell
        let season = seasonsAndEpisodes[indexPath.section + 1]
        episodeCell.setUpView(with: season![indexPath.row])
        return episodeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "episodeDetails", sender: episodesList[indexPath.row])
    }
}
