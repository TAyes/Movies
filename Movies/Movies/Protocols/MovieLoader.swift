//
//  MovieLoader.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation
import UIKit

protocol MovieDataSource {
    func loadMovies(fromURL: URL,compeletion: @escaping (Result<Movie, NetworkError>) -> Void)
    func loadMovieDetail(fromURL: URL,compeletion: @escaping (Result<MovieDetail, NetworkError>) -> Void)
}

final class MovieLoader: MovieDataSource {
    
    func loadMovies(fromURL: URL, compeletion: @escaping (Result<Movie, NetworkError>) -> Void) {
        do {
            let networkManager = NetworkManager()
            // Request data from the backend
            networkManager.request(fromURL: fromURL) { (result: Result<Movie, NetworkError>) in
                switch result {
                case .success(let response):
                    compeletion(.success(response))
                case .failure(let error):
                    compeletion(.failure(error))
                }
             }
        }
    }
    
    func loadMovieDetail(fromURL: URL, compeletion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        do {
            let networkManager = NetworkManager()
            // Request data from the backend
            networkManager.request(fromURL: fromURL) { (result: Result<MovieDetail, NetworkError>) in
                switch result {
                case .success(let response):
                    compeletion(.success(response))
                case .failure(let error):
                    compeletion(.failure(error))
                }
             }
        }
    }
    
}


