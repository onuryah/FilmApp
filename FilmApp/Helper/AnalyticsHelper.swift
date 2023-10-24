//
//  AnalyticsHelper.swift
//  FilmApp
//
//  Created by OnurAlp on 23.10.2023.
//

import FirebaseAnalytics

enum AnaltyticsConstants: String {
    case showed_film_details = "showed_film_details"
    case selected_film = "selected_film"
}

final class AnalyticsHelper {
    static let shared = AnalyticsHelper()
    
    func logEvent(event: AnaltyticsConstants, params: AnaltyticsConstants, value: Any) {
        customEvent(eventName: event.rawValue, params: [params.rawValue : value])
    }
    
    private func customEvent(eventName: String, params: [String: Any]) {
        Analytics.logEvent(eventName, parameters: params)
    }
}
