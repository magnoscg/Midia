//
//  FavoritesProvidable.swift
//  Midia
//
//  Created by Oscar canton on 11/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

protocol FavouritesProvidable {
    
    func getFavourites() -> [MediaItemDetailedProvidable]?
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable?
    func add(favorite: MediaItemDetailedProvidable)
    func remove(favoriteWithId favoriteId: String)
}
