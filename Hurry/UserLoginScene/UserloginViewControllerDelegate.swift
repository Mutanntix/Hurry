//
//  ObjcDelegate.swift
//  Hurry
//
//  Created by Мурад on 25.02.2022.
//

import Foundation
import UIKit

class UserloginViewControllerDelegate: UserloginViewControllerProtocol {
    
    func keyboardWillShow(notification: NSNotification, viewController: UIViewController) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardSize.cgRectValue

        if viewController.view.frame.origin.y == 0 {
            viewController.view.frame.origin.y -= (keyboardFrame.height * 0.8)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification, viewController: UIViewController) {
        if viewController.view.frame.origin.y != 0 {
            viewController.view.frame.origin.y = 0
        }
    }
    
    func changeTitleForLoginButton(buttons: [UIButton], vc: UIViewController) {
        guard let userVC = vc as? UserLoginViewController else { return }
        let attributedStringUserHasNoAcc = NSAttributedString(string: NSLocalizedString("I don't have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        let attributedStringUserHasAcc = NSAttributedString(string: NSLocalizedString("I already have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        
        for button in buttons {
            switch button {
            case userVC.loginButton:
                if button.titleLabel?.text == "Sign in" {
                    button.setTitle("Sign up", for: .normal)
                } else {
                    button.setTitle("Sign in", for: .normal)
                }
            case userVC.accountOwningButton:
                if button.titleLabel?.text == "I don't have an account" {
                    button.setAttributedTitle(attributedStringUserHasAcc, for: .normal)
                } else {
                    button.setAttributedTitle(attributedStringUserHasNoAcc, for: .normal)
                }
            default:
                break
            }
        }
    }
}
