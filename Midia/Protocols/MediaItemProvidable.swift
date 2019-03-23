//
//  MediaItemProvidable.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {
    
    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }

}
