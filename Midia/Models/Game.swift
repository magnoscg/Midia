//
//  Game.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct Game: MediaItemProvidable, MediaItemDetailedProvidable {
    
    let creatorName: String? = nil
    let rating: Float? = nil
    let numberOfReviews: Int? = nil
    let creationDate: Date? = nil
    let price: Float? = nil
    let description: String? = nil
    let mediaItemId: String = "id"
    let title: String = "A game"
    let imageURL: URL? = nil
}
