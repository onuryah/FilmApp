//
//  HomeEndPointItem.swift
//  FilmApp
//
//  Created by OnurAlp on 19.10.2023.
//

enum MainEndpointItem: Endpoint {
    
    case upcoming(query: String)
    
    var baseUrl: String { ApiConstant.BASE_URL }
    
    var path: String {
        switch self {
        case .upcoming(let query):
            return query
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
