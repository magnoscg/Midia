//
//  CoreDataStorageManager.swift
//  Midia
//
//  Created by Oscar canton on 12/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation
import CoreData

// TODO: capa de abstraccion para usar siempre media items

class CoreDataStorageManager: FavoritesProvidable {
    
    let mediaItemKind: MediaItemKind
    let stack = CoreDataStack.sharedInstance
    
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
    }
    
    
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        let context = stack.persistentContainer.viewContext
        let fectchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
        let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: true)
        let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
        fectchRequest.sortDescriptors = [dateSortDescriptor,priceSortDescriptor]
        do {
            let favorites = try context.fetch(fectchRequest)
            return favorites.map({ ($0.mappedObject()) })
        } catch {
            assertionFailure("Error fetching Media Items")
            return nil
        }
        
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        
        let context = stack.persistentContainer.viewContext
        let fectchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "booId = %@", favoriteId)
        fectchRequest.predicate = predicate
        do {
            let favorites = try context.fetch(fectchRequest)
            return favorites.last?.mappedObject()
        } catch {
            assertionFailure("Error fetching media Item by id \(favoriteId)")
            return nil
        }
        
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        let context = stack.persistentContainer.viewContext
        if let book = favorite as? Book {
            let bookManaged = BookManaged(context: context)
            bookManaged.bookId = book.bookId
            bookManaged.bookTitle = book.title
            bookManaged.publishDate = book.publishedDate
            bookManaged.coverURL = book.coverURL?.absoluteString
            bookManaged.bookDescription = book.description
            if let rating = book.rating {
                bookManaged.rating = rating
            }
            if let numberOfReviews = book.numberOfReviews {
                bookManaged.numberOfReviews = Int32 (numberOfReviews)
            }
            if let price = book.price {
                bookManaged.price = price
            }
            book.authors?.forEach({ (authorName) in
                let author = Author(context: context)
                author.fullName = authorName
                bookManaged.addToAuthors(author)
            })
            do {
                try context.save()
            } catch {
                assertionFailure("error saving context")
            }
        } else {
            fatalError("Not supported yet : )")
        }
    }
    
    
    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistentContainer.viewContext
        let fectchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "booId = %@", favoriteId)
        fectchRequest.predicate = predicate
        do {
            let favorites = try context.fetch(fectchRequest)
            favorites.forEach({ (bookManaged) in
                context.delete(bookManaged)
            })
            try context.save()
        } catch {
            assertionFailure("Error removing media Item with id \(favoriteId)")
        }
    }
    
    
}
