//
//  StorageManager.swift
//  Midia
//
//  Created by Oscar canton on 11/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .book)
   // static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)
    
}
