//
//  MovieTests.swift
//  MidiaTests
//
//  Created by Oscar canton on 23/3/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import XCTest
@testable import Midia

class MovieTests: XCTestCase {

    let decoder = JSONDecoder()
    var bestMovieEver: Movie!
    let coverURL = URL(string: "https://pics.filmaffinity.com/the_matrix-155050517-large.jpg")
    
    override func setUp() {
        super.setUp()
        
        bestMovieEver = Movie(movieId: 1, title: "Matrix", director: "Lilly Wachowski, Lana Wachowski", releaseDate: Date(timeIntervalSinceNow: 12313), description: "Un programador pirata recibe un día una misteriosa visita... Nada más se debe contar de la sinopsis de Matrix", coverURL: coverURL, genreName: "Ciencia ficcion", country: "USA", price: 3.99, previewURL: nil, rentalPrice: 1.99)
    }
    
    func testMovieExistence() {
        XCTAssertNotNil(bestMovieEver)
    }

    func testDecodeBookCollection() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movieItunesExample", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let firstMovie = movieCollection.results?.first
            XCTAssertNotNil(firstMovie?.movieId)
            XCTAssertNotNil(firstMovie?.title)
            
        } catch {
            XCTFail()
        }
    }
}
