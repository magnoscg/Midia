//
//  StorageManager.swift
//  Midia
//
//  Created by Oscar canton on 11/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

class StorageManager {
    
    
    static var shared : FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .movie)
    
    static func setup(withMediaItemKind mediaItemKind: MediaItemKind) {
        shared = CoreDataStorageManager(withMediaItemKind: mediaItemKind)
    }
    
}
