//
//  AuthViewModel.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 9.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseRemoteConfig

enum AuthViewModelChange {
    case didErrorOccurred(_ error: Error)
    case didSignUpSuccessful
}

final class AuthViewModel {
    
    var changeHandler: ((AuthViewModelChange) -> Void)?
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
            self.changeHandler?(.didSignUpSuccessful)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
            
            completion()
        }
    }
    
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { changed, error in
                    let isSignUpDisabled = remoteConfig.configValue(forKey: "isSignUpDisabled").boolValue
                    DispatchQueue.main.async {
                        completion(isSignUpDisabled)
                    }
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}
