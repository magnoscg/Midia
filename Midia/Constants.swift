//
//  Constants.swift
//  Midia
//
//  Created by Oscar canton on 4/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct GoogleBooksAPIConstant {
    
    private static let apiKey = Bundle.main.object(forInfoDictionaryKey: "apikey") as! String
    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL{
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    
    
    static func urlForBook(withId bookId: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(bookId)"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
        
        return components.url!
    }
    
}

struct ItunesMoviesAPIConstant {
    
    private static let media = "movie"
    private static let attribute = "movieTerm"
    private static let country = "es"
    
    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL{
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [URLQueryItem(name: "media", value: media)]
        components.queryItems?.append(URLQueryItem(name: "attribute", value: attribute))
        components.queryItems?.append(URLQueryItem(name: "country", value: country))
        components.queryItems?.append(URLQueryItem(name: "term", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    static func urlForMovie(withId movieId: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        components.queryItems = [URLQueryItem(name: "id", value: movieId)]
        components.queryItems?.append(URLQueryItem(name: "country", value: country))
        
        return components.url!
    }
    
    
}
