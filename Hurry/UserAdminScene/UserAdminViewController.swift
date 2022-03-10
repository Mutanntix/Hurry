//
//  UserAdminViewController.swift
//  Hurry
//
//  Created by Мурад on 04.03.2022.
//

import UIKit
import Foundation

protocol UserAdminKeyboardDelegate {
    func keyboardWillShow(notification: NSNotification, viewController: UIViewController)
    func keyboardWillHide(notification: NSNotification, viewController: UIViewController)
}

class UserAdminViewController: UIViewController, UITextFieldDelegate {
    
    var keyboardDelegate: UserAdminKeyboardDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.keyboardDelegate = KeyboardDelegate()
        
        firstInitializate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    private func firstInitializate() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        UserAdminVCSetupManager.shared.setupUserAdminVCMainView(viewController: self)
        UserAdminVCSetupManager.shared.setupUserAdminVCHeader(viewController: self)
    }
    
    
    //
    @objc private func keyboardWillShow(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillShow(notification: notification, viewController: self)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillHide(notification: notification, viewController: self)
    }
    
    @objc func goToShopVC() {
        self.navigationController?.popViewController(animated: false)
    }
}
