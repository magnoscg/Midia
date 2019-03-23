//
//  ItunesMoviesAPIConsumerNSURLSession.swift
//  Midia
//
//  Created by Oscar canton on 23/3/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

class ItunesMoviesAPIConsumerNSURLSession: MediaItemAPIConsumable {
    
    let session = URLSession.shared
    
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = ItunesMoviesAPIConstant.getAbsoluteURL(withQueryParams: ["top"])
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                failure(error)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? [])}
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            } else {
                DispatchQueue.main.async {
                    success([])
                }
            }
        }
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO:

    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: 

    }
    
    
}
