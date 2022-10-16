//
//  ProfileViewController.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 16.10.2022.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: CAViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
    }
    
    @IBAction private func didTapSignOutButton(_ sender: UIButton) {
        showAlert(title: "Warning",
                  message: "Are you sure to sign out?",
                  cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch {
                self.showError(error)
            }
        }
    }
}
