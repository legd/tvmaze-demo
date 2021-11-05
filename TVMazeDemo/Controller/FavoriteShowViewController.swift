//
//  FavoriteShowViewController.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 4/11/21.
//

import UIKit

protocol FavoriteShowDelegate {
    func updateFavoriteShows()
}

class FavoriteShowViewController: UIViewController {

    @IBOutlet weak var favoritesShowView: UICollectionView!
    private var favoriteShows = [FavoriteShow]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesShowView.delegate = self
        favoritesShowView.dataSource = self
        favoritesShowView.register(ShowCell.nib(), forCellWithReuseIdentifier: ShowCell.identifier)
    }

    func setUpView() {
        favoriteShows = Array(DBManager.shared.getAllShows()).sorted {
            $0.name < $1.name
        }
        favoritesShowView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteShowDetails" {
            let showDetails = segue.destination as! ShowDetailsViewController
            showDetails.show = sender as? ShowGeneric
            showDetails.delegate = self
        }
    }
}

// MARK: - UICollectionViewDataSource - UIColectionViewDelegate - UICollectionViewDelegateFlowLayout
extension FavoriteShowViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let show = favoriteShows[indexPath.row]
        let cellLarge = favoritesShowView.dequeueReusableCell(withReuseIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
        cellLarge.setUpView(with: show)
        return cellLarge
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favoriteShowDetails", sender: favoriteShows[indexPath.row].getShowAsGeneric())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(3)
    }
}

// MARK: - FavoriteShowDelegate
extension FavoriteShowViewController: FavoriteShowDelegate {
    
    func updateFavoriteShows() {
        setUpView()
    }
}
