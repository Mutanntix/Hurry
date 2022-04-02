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
    var isUserOnline = NetworkManager.shared.isConnected
    
    var keyboardDelegate: UserAdminKeyboardDelegate?
    var buttonsDelegate: UserAdminViewControllerProtocol?
    
    var mainView: UserAdminMainView {
        return self.view as! UserAdminMainView
    }
    
    override func loadView() {
        self.view = UserAdminMainView(frame: UIScreen.main.bounds)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.keyboardDelegate = KeyboardDelegate()
        self.buttonsDelegate = UserAdminViewControllerDelegate()
        firstInitializate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    private func firstInitializate() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.mainView.cityTF.delegate = self
        self.mainView.countryTF.delegate = self
        self.mainView.nickNameTF.delegate = self
        self.mainView.favoriteDrinkTF.delegate = self
        
        self.mainView.headerGoToShopButton.addTarget(self, action: #selector(goToShopVC), for: .touchUpInside)
        self.mainView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        self.mainView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        self.mainView.changePasswordButton.addTarget(self, action: #selector(changePassButtonPressed), for: .touchUpInside)
        self.mainView.connectButton.addTarget(self, action: #selector(connectButtonPressed), for: .touchUpInside)
    }
}

extension UserAdminViewController {
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillShow(notification: notification, viewController: self)
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillHide(notification: notification, viewController: self)
    }
    
    @objc func goToShopVC() {
        var shopVC: ShopViewController?
        guard let navigationController = self.navigationController else { return }
        
        for vc in navigationController.viewControllers {
            guard let attemptShopVC = vc as? ShopViewController else { continue }
            shopVC = attemptShopVC
        }
        guard let shopVC = shopVC else { return }

        self.navigationController?.popToViewController(shopVC, animated: false)
    }
    
        @objc fileprivate func saveButtonPressed() {
            self.mainView.mainScrollView.endEditing(true)
            self.buttonsDelegate?.saveChanges(button: self.mainView.saveButton, vc: self)
            
        }

        @objc fileprivate func connectButtonPressed() {
            print("connect button pressed")
            self.buttonsDelegate?.connectTelegram(button: self.mainView.connectButton)
        }
        
        @objc fileprivate func changePassButtonPressed() {
            let changePassVC = ChangePassViewController()
            
            self.present(UINavigationController(rootViewController: changePassVC), animated: true, completion: nil)
            self.buttonsDelegate?.openChangePasswordVC(button: self.mainView.changePasswordButton)
        }
        
        @objc fileprivate func logoutButtonPressed() {
            self.buttonsDelegate?.logout(button: self.mainView.logoutButton)
            guard let navigationController = self.navigationController else { return }
            var viewControllers = navigationController.viewControllers
            viewControllers.insert(UserLoginViewController(), at: 1)
            self.navigationController?.viewControllers = viewControllers
            self.navigationController?.popToViewController(viewControllers[1], animated: false)
        }
}
