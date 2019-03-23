//
//  BookCollection.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct BookCollection {

    let kind: String
    let totalItems: Int
    let items: [Book]?

}

extension BookCollection: Decodable {

    
}
