//
//  Movie.swift
//  Midia
//
//  Created by Oscar canton on 23/3/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Movie {
    
    let movieId: Int
    let title: String
    let director: String?
    let releaseDate: Date?
    let description: String?
    let coverURL: URL?
    let genreName: String?
    let country: String?
    let price: Float?
    let previewURL: URL?
    let rentalPrice: Float?
    
    init(movieId: Int ,title: String, director: String? = nil ,releaseDate: Date? = nil,description: String? = nil ,coverURL: URL? = nil ,genreName: String? = nil ,country: String? = nil ,price: Float? = nil ,previewURL: URL? = nil, rentalPrice: Float? = nil ) {
        self.movieId = movieId
        self.title = title
        self.director = director
        self.releaseDate = releaseDate
        self.description = description
        self.coverURL = coverURL
        self.genreName = genreName
        self.country = country
        self.price = price
        self.previewURL = previewURL
        self.rentalPrice = rentalPrice
    }
    
}

extension Movie: Codable {
    
    enum CodingKeys: String , CodingKey {
        
        case movieId = "trackId"
        case title = "trackName"
        case director = "artistName"
        case releaseDate
        case description = "longDescription"
        case coverURL = "artworkUrl100"
        case genreName = "primaryGenreName"
        case country
        case price = "trackPrice"
        case previewURL = "previewUrl"
        case rentalPrice = "trackRentalPrice"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        movieId = try container.decode(Int.self, forKey: .movieId)
        
        title = try container.decode(String.self, forKey: .title)
        director = try container.decodeIfPresent(String.self, forKey: .director)
        
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
        releaseDate = DateFormatter.moviesAPIDateFormatter.date(from: releaseDateString)
        } else {
            releaseDate = nil
        }
        
        description = try container.decodeIfPresent(String.self, forKey: .description)
        
        coverURL = try container.decodeIfPresent(URL.self, forKey: .coverURL)
        genreName = try container.decodeIfPresent(String.self, forKey: .genreName)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        
        price = try container.decodeIfPresent(Float.self, forKey: .price)
        previewURL = try container.decodeIfPresent(URL.self, forKey: .previewURL)
        rentalPrice = try container.decodeIfPresent(Float.self, forKey: .rentalPrice)
        
    }
    
}

extension Movie: MediaItemProvidable {
    var mediaItemId: String {
        return "\(movieId)"
    }
    
    var imageURL: URL? {
        return coverURL
    }
    
    
}

extension Movie: MediaItemDetailedProvidable {
    var creatorName: String? {
        return director
    }
    
    var rating: Float? {
        return nil
    }
    
    var numberOfReviews: Int? {
        return nil
    }
    
    var creationDate: Date? {
        return releaseDate
    }
    
    
    
}

