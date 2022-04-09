//
//  UserAdminViewControllerDelegate.swift
//  Hurry
//
//  Created by Мурад on 06.03.2022.
//

import Foundation
import UIKit

class UserAdminViewControllerDelegate: UserAdminViewControllerProtocol {
    func saveChanges(button: UIButton, vc: UserAdminViewController) {
        button.pulsate()
        button.isEnabled = false
        button.setTitle("", for: .normal)
        vc.mainView.activityIndicator
            .setActivityIndicatorForSaveButton(with: button.frame)

        vc.mainView.activityIndicator.animate(with: 2) {
            button.isEnabled = true
            button.setTitle("save", for: .normal)
        }
    }

    func connectTelegram(button: UIButton) {
        // connect logic
        button.pulsate()
    }
    
    func openChangePasswordVC(button: UIButton) {
        // openChangePassViewController logic
        button.pulsate()

    }
    
    func logout(button: UIButton) {

        NetworkManager.shared.deleteUser()
        
        button.pulsate()
    }
    
}
