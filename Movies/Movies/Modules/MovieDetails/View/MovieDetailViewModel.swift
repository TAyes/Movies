//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

// MARK: - protocol
protocol MovieDetailViewModelType {
    var movieDetail: Observable<MovieDetail?> { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    var movieId: Int? { get }
    func loadMoreData()
    func calculateRating(popularity: Double) -> String
}

class MovieDetailViewModel: MovieDetailViewModelType {
    
    // MARK: - Properties
    let isLoading: Observable<Bool> = .init(false)
    let error: Observable<String?> = .init(nil)
    let movieDetail: Observable<MovieDetail?> = .init(nil)
    let movieId: Int?
    
    private let movieLoader: MovieDataSource
    
    init(MovieId: Int, movieLoader: MovieDataSource = MovieLoader()) {
        self.movieLoader = movieLoader
        self.movieId = MovieId
        loadMoreData()
    }
    
    func loadMoreData() {
        loadData()
    }
    
    func calculateRating (popularity: Double) -> String {
        if popularity > 0 {
            return "\(round((popularity / 10) * 10) / 10.0)"
        }
        return "0"
    }
}

// MARK: - API Request
private extension MovieDetailViewModel {
    private func loadData() {
        guard let id = self.movieId else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            var urlComponents: URLComponents? {
                var urlComponents = URLComponents(string: NetworkManager.baseUrl + "movie/\(id)")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "api_key", value: Constants.apiKey)
                ]
                return urlComponents
            }
            
            guard let url = urlComponents?.url?.absoluteURL else { fatalError("Invalid URL") }
            
            self.movieLoader.loadMovieDetail(fromURL: url) { data in
                switch data {
                case let .success(response):
                    self.movieDetail.value = response
                    self.isLoading.value = false
                case let .failure(error):
                    self.error.value = error.localizedDescription
                }
            }
        }
    }
}

