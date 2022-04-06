//
//  ObjcDelegate.swift
//  Hurry
//
//  Created by Мурад on 25.02.2022.
//

import Foundation
import UIKit

enum LoginButtonState: Int {
    case login = 0
    case reg = 1
    
    func getLoginButtonState() -> Int {
        switch self {
        case .login:
            return 0
        case .reg:
            return 1
        }
    }
}

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
    
    func setStateForLoginButton(buttons: [UIButton], vc: UserLoginViewController) {
        let state = SignState.shared.state.getLoginButtonState()
        
        switch state {
        case 0:
            self.setButtonsForLoginState(buttons: buttons, vc: vc)
        case 1:
            self.setButtonsForRegState(buttons: buttons, vc: vc)
        default:
            break
        }
    }
    
    func setLoginState(vc: UserLoginViewController) {
        SignState.shared.state = LoginButtonState.login
    }
    
    func setRegState(vc: UserLoginViewController) {
        SignState.shared.state = LoginButtonState.reg
    }
    
    private func setButtonsForLoginState(buttons: [UIButton], vc: UserLoginViewController) {
        let attributedStringUserHasNoAcc = NSAttributedString(string: NSLocalizedString("I don't have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        
        for button in buttons {
            if button == vc.mainView.loginButton {
                button.setTitle("sign in", for: .normal)
                button.addTarget(vc, action: #selector(vc.loginButtonPressed), for: .touchUpInside)
            } else {
                button.setAttributedTitle(attributedStringUserHasNoAcc, for: .normal)
            }
        }
    }
    
    private func setButtonsForRegState(buttons: [UIButton], vc: UserLoginViewController) {
        let attributedStringUserHasNoAcc = NSAttributedString(string: NSLocalizedString("I already have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        
        for button in buttons {
            if button == vc.mainView.loginButton {
                button.setTitle("sign up", for: .normal)
                button.addTarget(vc, action: #selector(vc.loginButtonPressed), for: .touchUpInside)
            } else {
                button.setAttributedTitle(attributedStringUserHasNoAcc, for: .normal)
            }
        }
    }

}
