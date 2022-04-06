//
//  Alerts.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 05.04.2022.
//

import Foundation
import UIKit

enum AlertType {
    case passChangedAlert
    case passTextFieldsErrorAlert
    case warningAlert
    case logoutAlert
    case serverErrorAlert
    case loginRegErrorAlert
}

struct Alert {
    
    static func showAlert(vc: UIViewController,
                          message: String,
                          title: String,
                          alertType: AlertType,
                          complition: @escaping () -> Void
                          ) {
        
        switch alertType {
        case .passChangedAlert:
            let okAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            okAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                vc.dismiss(animated: true, completion: nil)
            }))
            
            DispatchQueue.main.async {
                vc.present(okAlert, animated: true)
            }
        case .passTextFieldsErrorAlert:
            let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Try again", style: .default))
            
            DispatchQueue.main.async {
                vc.present(errorAlert, animated: true)
            }
        case .warningAlert:
            let warningAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            warningAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                vc.dismiss(animated: true, completion: nil)
            }))
            warningAlert.addAction(UIAlertAction(title: "No", style: .cancel))
            
            DispatchQueue.main.async {
                vc.present(warningAlert, animated: true)
            }
        case .logoutAlert:
            let logoutAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                
                guard let userAdminVC = vc as? UserAdminViewController else { return }
                userAdminVC.networkDelegate?.deleteUser()
                guard let navigationController = userAdminVC.navigationController else { return }
                var viewControllers = navigationController.viewControllers
                let userLoginVc = UserLoginViewController()
                userLoginVc.networkDelegate = userAdminVC.networkDelegate
                viewControllers.insert(userLoginVc, at: 1)
                userAdminVC.navigationController?.viewControllers = viewControllers
                userAdminVC.navigationController?.popToViewController(viewControllers[1], animated: false)
            }))
            
            logoutAlert.addAction(UIAlertAction(title: "No", style: .cancel))
            
            DispatchQueue.main.async {
                vc.present(logoutAlert, animated: true)
            }
        case .serverErrorAlert:
            let serverErrorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            serverErrorAlert.addAction(UIAlertAction(title: "OK",
                                                     style: .default,
                                                     handler: { _ in
                complition()
            }))
            
            DispatchQueue.main.async {
                vc.present(serverErrorAlert, animated: true)
            }
        case .loginRegErrorAlert:
            let loginRegErrorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            loginRegErrorAlert.addAction(UIAlertAction(title: "OK",
                                                     style: .default,
                                                     handler: { _ in
                complition()
            }))
            
            DispatchQueue.main.async {
                vc.present(loginRegErrorAlert, animated: true)
            }
        }
    }
}
