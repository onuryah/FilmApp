//
//  RemoteConfigHelper.swift
//  FilmApp
//
//  Created by OnurAlp on 24.10.2023.
//

import FirebaseRemoteConfig

class RemoteConfigHelper {
    static let shared = RemoteConfigHelper()
    private init() { }
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let defaultValues: [String: NSObject] = [
        "remote_value": "" as NSObject
    ]
    
    func getRemoteConfig<T>(_ completion: @escaping (T?) -> Void) {
        remoteConfig.setDefaults(defaultValues)
            
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { [weak self] status, error in
            guard let self = self else { return }
            if status == .success, error == nil {
                self.remoteConfig.activate { _, error in
                    guard error == nil else {
                        completion(nil)
                        return
                    }
                    
                    let remoteValue = self.remoteConfig.configValue(forKey: "remote_value").stringValue
                    if let value = remoteValue as? T {
                        completion(value)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
}
