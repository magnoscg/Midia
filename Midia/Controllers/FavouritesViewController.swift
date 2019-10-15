//
//  FavoritesViewController.swift
//  Midia
//
//  Created by Oscar canton on 12/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let favoriteCellReuseIdentifier = "favoriteCellReuseIdentifier"
    
    var mediaItemProvider: MediaItemProvider!
    var favourites: [MediaItemDetailedProvidable] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

            if let storedFavorites = StorageManager.shared.getFavourites() {
                favourites = storedFavorites
                tableView.reloadData()
            }
    }
}
extension FavouritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }

        let mediaItem = favourites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        present(detailViewController, animated: true, completion: nil)
    }
}

extension FavouritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellReuseIdentifier) as? FavoriteTableViewCell else {
            fatalError()
        }
        cell.mediaItem = favourites[indexPath.row]
        return cell
    }

}
