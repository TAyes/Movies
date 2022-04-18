//
//  MovieViewModel.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

// MARK: - protocol
protocol MovieViewModelType {
    var moviesList: Observable<[MovieList]> { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    func loadMoreData()
}

class MovieViewModel: MovieViewModelType {
    
// MARK: - Properties
    let moviesList: Observable<[MovieList]> = .init([])
    let isLoading: Observable<Bool> = .init(false)
    let error: Observable<String?> = .init(nil)
    
    private var pageNo = 0
    private let limit = 500
    
    private var movies: [MovieList] = []
    private let moviesLoader: MovieDataSource
    // This variable ensure, no other API request has entertained while another one is still pending
    private var isDataReady = true {
        didSet {
            guard isDataReady else { return }
        }
    }
    // Pagination variable check if paging exceed its limit or not
    private var limitExceeded: Bool {
        guard pageNo <= limit else {
            return true
        }
        return false
    }
    
    init(moviesLoader: MovieDataSource = MovieLoader()) {
        self.moviesLoader = moviesLoader
        loadMoreData()
        
    }
    
    func loadMoreData() {
        guard !limitExceeded, self.isDataReady else { return }
        loadData(page: pageNo)
        pageNo += 1
    }
    
}
// MARK: - API REQUEST
private extension MovieViewModel {
   private func loadData(page: Int) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            var urlComponents: URLComponents? {
                
                let api_key = Constants.apiKey
                let sort_by = "popularity.des"
                let page = "\(self.pageNo)"
                let include_adult = "false"
                
                var urlComponents = URLComponents(string: NetworkManager.baseUrl + "discover/movie")
                urlComponents?.queryItems = [
                    URLQueryItem(name: "api_key", value: api_key),
                    URLQueryItem(name: "sort_by", value: sort_by),
                    URLQueryItem(name: "include_adult", value: include_adult),
                    URLQueryItem(name: "page", value: page)
                    
                ]
                return urlComponents
            }
            
            guard let url = urlComponents?.url?.absoluteURL else { fatalError("Invalid URL") }
            
            self.isDataReady = false
            self.moviesLoader.loadMovies(fromURL: url) { data in
                switch data {
                case let .success(response):
                    self.movies.append(contentsOf: response.results ?? [])
                    self.moviesList.value = self.movies
                    self.isLoading.value = false
                case let .failure(error):
                    self.error.value = error.localizedDescription
                }
                self.isDataReady = true
            }
        }
    }
}

