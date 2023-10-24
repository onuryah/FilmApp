//
//  DetailsModel.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

// MARK: - Details
struct Details: Codable {
    let title, year: String?
    let genre, director: String?
    let plot: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let imdbID: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case director = "Director"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case response = "Response"
        case imdbID
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source, value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
