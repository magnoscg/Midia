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
    let encoder = JSONEncoder()
    
    var bestMovieEver: Movie!
    let coverURL = URL(string: "https://pics.filmaffinity.com/the_matrix-155050517-large.jpg")
    let previewURL = URL(string: "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video114/v4/c2/25/75/c2257578-3fe6-0ea0-56d2-2ce7903ee5a9/mzvf_3278624224628289627.640x354.h264lc.U.p.m4v")
    override func setUp() {
        super.setUp()
        
        bestMovieEver = Movie(movieId: 1, title: "Matrix", director: "Lilly Wachowski, Lana Wachowski", releaseDate: Date(timeIntervalSinceNow: 12313), description: "Un programador pirata recibe un día una misteriosa visita... Nada más se debe contar de la sinopsis de Matrix", coverURL: coverURL, genreName: "Ciencia ficcion", country: "USA", price: 3.99, previewURL: previewURL, rentalPrice: 1.99)
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
    
    func testDecodeEncodedMovie() {
        
        do {
            let movieData = try encoder.encode(bestMovieEver)
            XCTAssertNotNil(movieData)
            let movie = try decoder.decode(Movie.self, from: movieData)
            XCTAssertNotNil(movie)
            XCTAssertNotNil(movie.movieId)
            XCTAssertNotNil(movie.title)
            XCTAssertNotNil(movie.director)
            XCTAssertNotNil(movie.releaseDate)
            XCTAssertNotNil(movie.description)
            XCTAssertNotNil(movie.coverURL)
            XCTAssertNotNil(movie.genreName)
            XCTAssertNotNil(movie.country)
            XCTAssertNotNil(movie.price)
            XCTAssertNotNil(movie.previewURL)
            XCTAssertNotNil(movie.rentalPrice)
            
        } catch {
            XCTFail()
        }
    }
}
