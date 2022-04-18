//
//  Network+Error.swift
//  Movies
//
//  Created by shisheo portal on 18/04/2022.
//

import Foundation

enum NetworkError: LocalizedError {
    case badRequest(String)
    case noData
    case failedToParseData
    case invalidResponse
    case invalidStatusCode(Int)
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical decoding difficulty, we can't Parse the data"
        case let .badRequest(messageError):
            return messageError
        case .invalidResponse:
            return "invalid Response"
        case let .invalidStatusCode(statusCode):
            return "invalid Response with status Code \(statusCode)"
        default:
            return "Something went wrong"
        }
    }
}

