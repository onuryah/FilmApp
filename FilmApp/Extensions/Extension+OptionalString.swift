//
//  Extension+OptionalString.swift
//  FilmApp
//
//  Created by OnurAlp on 25.10.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var URLFormat: URL? {
        return URL(string: self ?? "")
    }
}
