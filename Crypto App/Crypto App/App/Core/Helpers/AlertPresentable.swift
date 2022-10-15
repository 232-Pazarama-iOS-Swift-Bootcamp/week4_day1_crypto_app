//
//  AlertManager.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 15.10.2022.
//

import UIKit

protocol AlertPresentable { }

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String? = nil,
                   message: String? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true)
    }
    
    func showError(_ error: Error) {
        showAlert(title: "Error Occurred",
                  message: error.localizedDescription)
    }
}
