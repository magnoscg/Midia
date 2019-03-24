//
//  DetailViewController.swift
//  Midia
//
//  Created by Oscar canton on 5/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var ratingsContainerView: UIView!
    
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    var mediaItemId: String!
    var mediaItemProvider: MediaItemProvider! // Deberia ser opcional
    var detailedMediaItem: MediaItemDetailedProvidable?
    
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if let favorite = StorageManager.sharedMovie.getFavorite(byId: mediaItemId) {
            detailedMediaItem = favorite
            syncViewWithModel()
            loadingView.isHidden = true
            isFavorite = true
            toggleFavoriteButton.setTitle("Remove from favorites", for: .normal)
        } else {
            
            // Pedirle al media provider el detalle del media Item con el id recibido
            
            mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (detailedMediaItem) in
                self?.loadingView.isHidden = true
                self?.detailedMediaItem = detailedMediaItem
                self?.syncViewWithModel()
                
            }) { [weak self] (error) in
                self?.loadingView.isHidden = true
                // Creo una alarma, le añado accion con handler, presento alerta
                let alertController = UIAlertController(title: nil, message: "Error recuperando media item", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (_) in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else {
            return
        }
        
        // Obligatorio
        titleLabel.text = mediaItem.title
        descriptionTextView.text = mediaItem.description

        // me vale que sea nil
        if let url = mediaItem.imageURL {
            imageView.loadImage(fromURL: url)
        }
        
        // Stack View, si lo tenemos lo pintamos, si no ocultamos el elemento para que la stack view reorganice
        if let creators = mediaItem.creatorName {
            creatorsLabel.text = creators
        }else {
            creatorsLabel.isHidden = true
        }
        
        if let rating = mediaItem.rating,
            let numberOfReviews = mediaItem.numberOfReviews {
            ratingLabel.text = "Rating \(rating)"
            numberOfReviewsLabel.text = "\(numberOfReviews) reviews"
        }else {
            ratingsContainerView.isHidden = true
            ratingLabel.isHidden = true
            numberOfReviewsLabel.isHidden = true
        }
        if let creationDate = mediaItem.creationDate {
            creationDateLabel.text = DateFormatter.booksAPIDateFormatter.string(from: creationDate)
        } else {
            creationDateLabel.isHidden = true
        }
        if let price = mediaItem.price {
            buyButton.setTitle("Buy for \(price)$", for: .normal)
        } else {
            buyButton.isHidden = true
        }

    }
    
    
    //MARK: Actions
    
    @IBAction func didTapInCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapToggleFavorite(_ sender: Any) {
        guard let favorite = detailedMediaItem else {
            return
        }
        isFavorite.toggle()
        if isFavorite {
            StorageManager.sharedMovie.add(favorite: favorite)
            toggleFavoriteButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            StorageManager.sharedMovie.remove(favoriteWithId: favorite.mediaItemId)
            toggleFavoriteButton.setTitle("Add favorite", for: .normal)
        }
    }
    
    
}
