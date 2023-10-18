//
//  EndPoint.swift
//  FilmApp
//
//  Created by OnurAlp on 18.10.2023.
//

import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod

public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
}

public extension Endpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
    var parameters: [String: Any] { [:] }
    var url: String { "\(baseUrl)\(path)"}
}
