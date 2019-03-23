//
//  GoogleBooksAPIConsumerURLSession.swift
//  Midia
//
//  Created by Oscar canton on 4/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {
    

    let session =  URLSession.shared
    
    let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!

    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        print(GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["2019"]))
        
        let url = GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["2019"])
        let task = session.dataTask(with: url) { (data, response, error) in
        // si hay error, lo paso para arriba con la closure de failure
            if let error = error {
                failure(error)
                return
            }
            if let data = data  {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { success(bookCollection.items ?? [])}
                }catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable])-> Void, failure: @escaping (Error?)-> Void){
        // TODO: completar en casa
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: completar en casa

    }
    
}
