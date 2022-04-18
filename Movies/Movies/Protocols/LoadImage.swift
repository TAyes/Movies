//
//  LoadImage.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Combine
import UIKit

protocol LoadImageDataSource {
    func loadImage(for news: String) -> AnyPublisher<UIImage?, Never>
}

extension LoadImageDataSource {
    func loadImage(for imageUrl: String) -> AnyPublisher<UIImage?, Never> {
        return Just(imageUrl)
         .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
             let url = URL(string: imageUrl)
             return ImageLoader.shared.loadImage(from: url ?? URL(fileURLWithPath: ""))
         })
         .eraseToAnyPublisher()
     }
}
