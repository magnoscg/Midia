//
//  ItunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Oscar canton on 23/3/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import Alamofire

class ItunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        //print(ItunesMoviesAPIConstant.getAbsoluteURL(withQueryParams: ["top"]))
        Alamofire.request(ItunesMoviesAPIConstant.getAbsoluteURL(withQueryParams: ["top"])).responseData { (response) in
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                }catch {
                    failure(error)
                }
            }
        }
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let paramsList = queryParams.components(separatedBy: " ")
        
        Alamofire.request(ItunesMoviesAPIConstant.getAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                }catch {
                    failure(error)
                }
            }
        }
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ItunesMoviesAPIConstant.urlForMovie(withId: mediaItemId)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    if let movie = movieCollection.results?.first {
                        success(movie)
                    }
                    
                }catch {
                    failure(error)
                }
            }
        }
    }
    
}
