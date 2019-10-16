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
        
        switch mediaItemKind {
        case .book:
            
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: true)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor,priceSortDescriptor]
            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.map({$0.mappedObject()})
            } catch {
                assertionFailure("Error fetching Media Items")
                return nil
            }
        case .movie:
            
            let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor,priceSortDescriptor]
            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.map({$0.mappedObject()})
            } catch {
                assertionFailure("Error fetching Media Items")
                return nil
            }
            
        default:
            assertionFailure("mediaItemKind not implemented yet")
            return nil
        }
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        
        let context = stack.persistentContainer.viewContext
        
        switch mediaItemKind {
            
        case .book:
            
            let fectchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
            fectchRequest.predicate = predicate
            do {
                let favorites = try context.fetch(fectchRequest)
                return favorites.last?.mappedObject()
            } catch {
                assertionFailure("Error fetching media Item by id \(favoriteId)")
                return nil
            }
        
        case .movie:
            
            let fectchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "movieId = %@", favoriteId)
            fectchRequest.predicate = predicate
            do {
                let favorites = try context.fetch(fectchRequest)
                return favorites.last?.mappedObject()
            } catch {
                assertionFailure("Error fetching media Item by id \(favoriteId)")
                return nil
            }
            
        default:
            
            assertionFailure("mediaItemKind not implemented yet")
            return nil
        }
           
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        let context = stack.persistentContainer.viewContext
        
        switch mediaItemKind {
            
        case .book:
            
            if let book = favorite as? Book {
                let bookManaged = BookManaged(context: context)
                bookManaged.bookId = book.bookId
                bookManaged.bookTitle = book.title
                bookManaged.publishedDate = book.publishedDate
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
        
        case .movie:
            
            if let movie = favorite as? Movie {
                let movieManaged = MovieManaged(context: context)
                movieManaged.movieId = Int32(movie.movieId)
                movieManaged.movieTitle = movie.title
                movieManaged.releaseDate = movie.releaseDate
                movieManaged.coverURL = movie.coverURL?.absoluteString
                movieManaged.movieDescription = movie.description
                
                if let genreName = movie.genreName {
                    movieManaged.genreName = genreName
                }
                if let country = movie.country {
                    movieManaged.country = country
                }
                if let price = movie.price {
                    movieManaged.price = price
                }

                do {
                    try context.save()
                } catch {
                    assertionFailure("error saving context")
                }
            } else {
                fatalError("Not supported yet : )")
            }
    
        default:
            assertionFailure("mediaItemKind not implemented yet")
        }
 
    }
    
    
    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistentContainer.viewContext
        
        switch mediaItemKind {
            
        case .book:
            
            let fectchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
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
         
        case .movie:
            
            let fectchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "movieId = %@", favoriteId)
            fectchRequest.predicate = predicate
            do {
                let favorites = try context.fetch(fectchRequest)
                favorites.forEach({ (movieManaged) in
                    context.delete(movieManaged)
                })
                try context.save()
            } catch {
                assertionFailure("Error removing media Item with id \(favoriteId)")
            }
            
        default:
            assertionFailure("mediaItemKind not implemented yet")
        }
        
       
    }
    
    
}
