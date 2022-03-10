//
//  UserAdminViewControllerDelegate.swift
//  Hurry
//
//  Created by Мурад on 06.03.2022.
//

import Foundation
import UIKit

class UserAdminViewControllerDelegate: UserAdminViewControllerProtocol {
    func saveChanges(view: UIView, button: UIButton) {
        button.pulsate()
        
        view.alpha = 0.9
        view.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowAnimatedContent) {
                view.alpha = 0
            }
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
        // logout logic
        button.pulsate()
    }
    
}
