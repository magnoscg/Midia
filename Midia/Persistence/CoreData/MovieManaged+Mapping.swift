//
//  MovieManaged+Mapping.swift
//  Midia
//
//  Created by Oscar canton on 24/3/19.
//  Copyright © 2019 Oscar Canton. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
        
        let coverUrl: URL? = coverURL != nil ? URL(string: coverURL!) : nil
        let previewUrl: URL? = previewURL != nil ? URL(string: previewURL!) : nil
        
        return Movie(movieId: Int(movieId), title: movieTitle!, director: director, releaseDate: releaseDate, description: movieDescription, coverURL: coverUrl!, genreName: genreName, country: country, price: price, previewURL: previewUrl, rentalPrice: rentalPrice)
    }
}
