//
//  FavoritesViewController.swift
//  Midia
//
//  Created by Oscar canton on 12/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let favoriteCellReuseIdentifier = "favoriteCellReuseIdentifier"
    
    var mediaItemProvider: MediaItemProvider!
    var favorites: [MediaItemDetailedProvidable] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let storedFavorites = StorageManager.shared.getFavorites() {
                favorites = storedFavorites
                tableView.reloadData()
            }
    }
    
}
extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }

        let mediaItem = favorites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        present(detailViewController, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellReuseIdentifier) as? FavoriteTableViewCell else {
            fatalError()
        }
        cell.mediaItem = favorites[indexPath.row]
        return cell
    }

}
