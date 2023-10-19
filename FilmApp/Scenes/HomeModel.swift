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
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Film: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}