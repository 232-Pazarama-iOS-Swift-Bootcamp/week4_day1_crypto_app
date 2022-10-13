//
//  AuthViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 9.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseRemoteConfig

final class AuthViewController: UIViewController {
    
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            titleLabel.text = title
            confirmButton.setTitle(title, for: .normal)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var credentionTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Auth"
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                remoteConfig.activate { changed, error in
                    let isSignInDisabled = remoteConfig.configValue(forKey: "isSignUpDisabled").boolValue
                    DispatchQueue.main.async {
                        self.segmentedControl.isHidden = isSignInDisabled
                    }
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
    @IBAction private func didTapLoginButton(_ sender: UIButton) {
        guard let credential = credentionTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            Auth.auth().signIn(withEmail: credential, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                let cryptoListViewModel = CryptoListViewModel()
                let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)
                
//                let favoritesViewModel = FavoritesViewModel()
//                let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
                
//                let tabBarController = UITabBarController()
//                tabBarController.viewControllers = []
                self.navigationController?.pushViewController(cryptoListViewController, animated: true)
            }
        case .signUp:
            Auth.auth().createUser(withEmail: credential, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("SIGN UP SUCCESSFUL!")
            }
        }
    }
    
    @IBAction private func didValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
    }
}
