//
//  BookManaged+Mapping.swift
//  Midia
//
//  Created by Oscar canton on 12/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation

extension BookManaged {
    
    
    
    func mappedObject() -> Book {
        
        let authorsList = authors?.map({ (author) -> String in
            let author = author as! Author
            return author.fullName!
        })
        
        let url: URL? = coverURL != nil ? URL(string: coverURL!) : nil
        
            
            return Book(bookId: bookId!, title: bookTitle!, authors: authorsList, publishedDate: publishDate, description: bookDescription, coverUrl: url , rating: rating, numberOfReviews: Int (numberOfReviews), price: price)
            
        }

}
