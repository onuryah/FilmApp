//
//  HomeModel.swift
//  FilmApp
//
//  Created by OnurAlp on 19.10.2023.
//

import Foundation

// MARK: - Films
struct Films: Codable {
    let search: [Film]?
    let totalResults, response, error: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}

// MARK: - Search
struct Film: Codable {
    let imdbID: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case imdbID
        case poster = "Poster"
    }
}
