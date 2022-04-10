//
//  KeyboardDelegate.swift
//  Hurry
//
//  Created by Мурад on 07.03.2022.
//

import Foundation
import UIKit

class KeyboardDelegate: UserAdminKeyboardProtocol {
    
    func keyboardWillShow(notification: NSNotification, viewController: UIViewController) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardSize.cgRectValue

        if viewController.view.frame.origin.y == 0 {
            viewController.view.frame.origin.y -= (keyboardFrame.height * 0.7)
        }
    }
    
    func keyboardWillHide(notification: NSNotification, viewController: UIViewController) {
        if viewController.view.frame.origin.y != 0 {
            viewController.view.frame.origin.y = 0
        }
    }
}
