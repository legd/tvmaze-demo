//
//  ViewController.swift
//  TVMazeDemo
//
//  Created by Luis Guzman on 31/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tvShowList: UICollectionView!
    var isWating = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvShowList.delegate = self
        tvShowList.dataSource = self
        searchBar.delegate = self
        tvShowList.register(ShowCell.nib(), forCellWithReuseIdentifier: ShowCell.identifier)
    }
    
    func setUpView() {
        TVShowRequest.getAllShows(whileLoading: {},
                                  whenLoaded: {
                                        self.tvShowList.reloadData()
                                  },
                                  onError: { message, data in
                                        print("Error: \(message)")
                                  })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let showDetails = segue.destination as! ShowDetailsViewController
            showDetails.show = sender as? ShowGeneric
        }
    }
}

// MARK: - UICollectionViewDataSource - UIColectionViewDelegate - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TVMazeShows.sharedInstance.showList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let show = TVMazeShows.sharedInstance.showList[indexPath.row]
        let cellLarge = tvShowList.dequeueReusableCell(withReuseIdentifier: ShowCell.identifier, for: indexPath) as! ShowCell
        cellLarge.setUpView(with: show)
        return cellLarge
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: TVMazeShows.sharedInstance.showList[indexPath.row].getShowAsGeneric())
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isWating {
            isWating = true
            TVShowRequest.updateShows(whileLoading: {},
                                      whenLoaded: {
                                            self.isWating = false
                                            self.tvShowList.reloadData()
                                      },
                                      onError: { message, data in
                                            print("Error: \(message)")
                                      })
        }
    }
}


// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // Disable due to a bug
//        TVShowRequest.searchShow(query: searchBar.text!,
//                                 whileLoading: {},
//                                 whenLoaded: {
//                                    DispatchQueue.main.async {
//                                        self.tvShowList.reloadData()
//                                    }
//                                 },
//                                 onError: { message, data in
//                                    print("Error con: \(message)")
//                                 })
    }
}
