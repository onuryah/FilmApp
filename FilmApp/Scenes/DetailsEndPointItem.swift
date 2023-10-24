//
//  DetailsEndPointItem.swift
//  FilmApp
//
//  Created by OnurAlp on 20.10.2023.
//

enum DetailsEndpointItem: Endpoint {
    
    case upcoming(query: String)
    
    var baseUrl: String { ApiConstant.BASE_URL }
    
    var path: String {
        switch self {
        case .upcoming(let query):
            return ApiConstant.getPathForDetailsService(upcoming: query)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
