//
//  GoogleBooksAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Oscar canton on 4/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation
import Alamofire



class GoogleBooksAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLastestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: ["2019"])).responseData { (response) in
            
            switch response.result {
                case .failure(let error):
                    failure(error)
                case .success(let value):
                        do {
                            let decoder = JSONDecoder()
                            let bookCollection = try decoder.decode(BookCollection.self, from: value)
                            success(bookCollection.items ?? [])
                        }catch {
                            failure(error)
                        }
            }
        }
        
        
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable])-> Void, failure: @escaping (Error?)-> Void){
        
         let paramsList = queryParams.components(separatedBy: " ")
        
        Alamofire.request(GoogleBooksAPIConstant.getAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: value)
                    success(bookCollection.items ?? [])
                }catch {
                    failure(error)
                }
            }
        }
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void){
        
        Alamofire.request(GoogleBooksAPIConstant.urlForBook(withId: mediaItemId)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let book = try decoder.decode(Book.self, from: value)
                    success(book)
                }catch {
                    failure(error)
                }
            }
        }
    }
}
