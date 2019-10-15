//
//  HomeViewController.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

enum MediaItemControllerState {
    case loading
    case noResults
    case failure
    case ready
}

class HomeViewController: UIViewController {

    let mediaItemCellIdentifier = "mediaItemCell"

    var mediaItemProvider: MediaItemProvider!
    private var mediaItems: [MediaItemProvidable] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scChooseMediaItem: UISegmentedControl!
    
    var state: MediaItemControllerState = .ready {
        willSet {
            guard state != newValue else {return}
            
            [collectionView, activityIndicatorView, statusLabel].forEach { (view) in
                view?.isHidden = true
                
            }
            
            switch newValue {
                
            case .loading:
                activityIndicatorView.isHidden = false
            case .noResults:
                statusLabel.isHidden = false
                statusLabel.text = "No hay nada que mostrar!!"
            case .failure:
                statusLabel.isHidden = false
                statusLabel.text = "Error conectando!!"
            case .ready:
                collectionView.isHidden = false
                collectionView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    
    @IBAction func chooseMediaItemKind(_ sender: Any) {
        switch scChooseMediaItem.selectedSegmentIndex {
        case 0:
            self.mediaItemProvider = MediaItemProvider(withMediaItemKind: .movie)
            config()
            break
        case 1:
            self.mediaItemProvider = MediaItemProvider(withMediaItemKind: .book)
            config()
            break
        default:
            break
        }
    }
    
    func config() {
        
        state = .loading
        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            
            self?.mediaItems = mediaItems
            self?.state = mediaItems.count > 0 ? .ready : .noResults
        }) { [weak self] (error) in
            self?.state = .failure
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // Creamos el detail view controller
        
        guard let detailViewcontroller = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        
        // le pasamos la informacion ( id , mediaprovider)
        let mediaItem = mediaItems[indexPath.item]
        detailViewcontroller.mediaItemId = mediaItem.mediaItemId
        detailViewcontroller.mediaItemProvider = mediaItemProvider
        
        // lo mostramos
        present(detailViewcontroller, animated: true, completion: nil)
        
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }

}
