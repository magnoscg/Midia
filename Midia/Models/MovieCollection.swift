//
//  MovieCollection.swift
//  Midia
//
//  Created by Oscar canton on 23/3/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct MovieCollection {
    
    let resultCount: Int
    let results: [Movie]?
}

extension MovieCollection: Decodable {

}
