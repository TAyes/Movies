//
//  MovieDetail.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
