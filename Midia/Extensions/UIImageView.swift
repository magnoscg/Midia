//
//  UIImageView.swift
//  Midia
//
//  Created by Oscar canton on 5/3/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        DispatchQueue.global().async {  [weak self] in 
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }

            }
        }
    }
    
}
