//
//  Constants.swift
//  Midia
//
//  Created by Oscar canton on 4/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

struct GoogleBooksAPIConstant {
    
    private static let apiKey = "AIzaSyBioerjAnxgmanbaPiOi45Xcb-khV7u5qw"
    
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
