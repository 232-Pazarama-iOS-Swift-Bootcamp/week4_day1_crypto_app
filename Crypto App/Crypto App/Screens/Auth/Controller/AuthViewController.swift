//
//  AuthViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 9.10.2022.
//

import UIKit

final class AuthViewController: CAViewController {
    
    private let viewModel: AuthViewModel
    
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
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.showAlert(title: "SIGN UP SUCCESSFUL!")
            }
        }
        /*
        flickrApiProvider.request(.getRecentPhotos) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                print(String(decoding: response.data, as: UTF8.self))
            }
        }
        */
        title = "Auth"
        
        viewModel.fetchRemoteConfig { isSignUpDisabled in
            self.segmentedControl.isHidden = isSignUpDisabled
        }
    }
    
    @IBAction private func didTapLoginButton(_ sender: UIButton) {
        guard let credential = credentionTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                let cryptoListViewModel = CryptoListViewModel()
                let cryptoListViewController = CryptoListViewController(viewModel: cryptoListViewModel)
                
                let favoritesViewModel = FavoritesViewModel()
                let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [cryptoListViewController, favoritesViewController]
                self.navigationController?.pushViewController(tabBarController, animated: true)
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
    }
    
    @IBAction private func didValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
    }
}
