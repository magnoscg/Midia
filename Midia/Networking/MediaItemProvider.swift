//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Oscar canton on 28/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

class MediaItemProvider {


    
    let mediaItemKind: MediaItemKind
    let apiConsumer: MediaItemAPIConsumable
    
    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
        case .movie, .game:
            fatalError("MediaItemKind not supported yet :( coming soon")
        }
    }

    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // guardar en cache
        // comprobar que estamos hilo principal
        apiConsumer.getLastestMediaItems(onSuccess: { (mediaItems) in
            
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }
    
    func getSearchMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable])-> Void, failure: @escaping (Error?)-> Void){
        
        apiConsumer.getMediaItems(withQueryParams: queryParams, success: { (mediaItems)in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }) {(error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
        
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        apiConsumer.getMediaItem(byId: mediaItemId, success: { (mediaItem) in
            assert(Thread.current == Thread.main)
            success(mediaItem)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
    }

    
}

