//
//  ApiConstant.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

struct ApiConstant {
    static let BASE_URL = "https://www.omdbapi.com/"
    static let PATH = ""
    static let API_KEY = "&apikey="
    static let API_KEY_VALUE = "b508dfa4"
    static let SEARCH_TERM = "?s="
    static let Page = "&page="
    
    static func getPathForHomeService(upcoming: String, page: String) -> String {
        SEARCH_TERM+upcoming+API_KEY+API_KEY_VALUE+Page+page
    }
}
