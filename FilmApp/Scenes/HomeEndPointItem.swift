//
//  HomeEndPointItem.swift
//  FilmApp
//
//  Created by OnurAlp on 19.10.2023.
//

enum MainEndpointItem: Endpoint {
    
    case upcoming(query: String, page: String)
    
    var baseUrl: String { ApiConstant.BASE_URL }
    
    var path: String {
        switch self {
        case .upcoming(let query, let page):
            return ApiConstant.getPathForHomeService(upcoming: query, page: page)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
