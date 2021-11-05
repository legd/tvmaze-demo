//
//  EpisodeNameCell.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 3/11/21.
//

import UIKit

@IBDesignable
class EpisodeNameCell: UITableViewCell {
    
    static let identifier = "EpisodeNameCell"
    @IBOutlet weak var name: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "EpisodeNameCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpView(with episode: Episode) {
        name.text = episode.name
    }
    
}
