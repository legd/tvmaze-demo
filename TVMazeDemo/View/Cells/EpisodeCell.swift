//
//  EpisodeCell.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import UIKit

@IBDesignable
class EpisodeCell: UICollectionViewCell {

    static let identifier = "EpisodeCell"
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var seasonAndEpisodeNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "EpisodeCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpView(with episode: Episode) {
        poster.imageFromUrl(url: URL(string: episode.image.medium)!)
        seasonAndEpisodeNumber.text = "S\(episode.season)E\(episode.number)"
        name.text = episode.name
        summary.text = episode.summary
    }

}
