//
//  ShowCellLarge.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 2/11/21.
//

import UIKit

@IBDesignable
class ShowCell: UICollectionViewCell {

    static let identifier = "ShowCellLarge"
    @IBOutlet weak var showPoster: UIImageView!
    @IBOutlet weak var showName: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ShowCellLarge", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpView(with show: TVShow) {
        showName.text = show.name
        showPoster.imageFromUrl(url: URL(string: show.image.medium)!)
    }
    
    func setUpView(with show: FavoriteShow) {
        showName.text = show.name
        showPoster.imageFromUrl(url: URL(string: show.image)!)
    }

}
