//
//  String+Path.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//


extension String {
    
    func fullImagePath(size: MoviePosterSize) -> String {
        var imageSize = ""
        switch size {
        case .w500:
            imageSize = MoviePosterSize.w500.rawValue
        case .original:
            imageSize = MoviePosterSize.original.rawValue
        }
        return Constants.imageBaseUrl + imageSize + self
    }
    
}

