//
//  Movie.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let results: [MovieList]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct MovieList: Codable {
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
