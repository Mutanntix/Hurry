//
//  ViewController.swift
//  Hurry
//
//  Created by Мурад on 21.02.2022.
//

import UIKit
import SnapKit
import Alamofire

protocol UserloginViewControllerProtocol: AnyObject {
    func keyboardWillShow(notification: NSNotification,
                          viewController: UIViewController)
    
    func keyboardWillHide(notification: NSNotification,
                          viewController: UIViewController)
    
    func setStateForLoginButton(buttons: [UIButton],
                                vc: UserLoginViewController)
}

class UserLoginViewController: UIViewController, UITextFieldDelegate {

    var userLoginVCDelegate: UserloginViewControllerProtocol?
    
    weak var networkDelegate: NetworkDelegate?
    var state = SignState.shared.state
    
    var mainView: UserLoginView {
        return self.view as! UserLoginView
    }
    
    override func loadView() {
        self.view = UserLoginView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.loginTextField.delegate = self
        mainView.passwordTextField.delegate = self
        userLoginVCDelegate = UserloginViewControllerDelegate()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)


        firstInitializate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        loginButtonPressed()
        return true
    }

    private func firstInitializate() {
        self.navigationItem.hidesBackButton = true
        
        userLoginVCDelegate?.setStateForLoginButton(
            buttons: [mainView.loginButton, mainView.accountOwningButton],
            vc: self)
        mainView.accountOwningButton.addTarget(self,
                                               action: #selector(accountOwningButtonPressed),
                                               for: .touchUpInside)
        mainView.loginButton.addTarget(self,
                                       action: #selector(loginButtonPressed),
                                       for: .touchUpInside)
    }
    

    
    
    //MARK: CONTROLLER METHODS
    
    @objc func loginButtonPressed() {
        view.endEditing(true)
        guard
            let login = mainView.loginTextField.text,
            let password = mainView.passwordTextField.text else { return }
        (login != "" && password != "") ? mainView.loginButton.pulsate() : mainView.loginButton.shake()
        
        switch state {
        case .login:
            networkDelegate?.loginUser(login: login,
                                       password: password) { [weak self] isUidAvailable in
                
                guard let self = self else { return }
                if isUidAvailable {
                    let shopVC = ShopViewController()
                    shopVC.networkDelegate = self.networkDelegate
                    self.navigationController?.pushViewController(shopVC, animated: true)
                } else {
                    Alert.showAlert(vc: self,
                                    message: "Login or password is incorrect!",
                                    title: "Problems with logging in",
                                    alertType: .loginRegErrorAlert,
                                    complition: {})
                }
            }
        case .reg:
            networkDelegate?.regUser(login: login,
                                     password: password,
                                     completion: { [weak self] isUidAvailable in
                
                guard let self = self else { return }
                if isUidAvailable {
                    let shopVC = ShopViewController()
                    shopVC.networkDelegate = self.networkDelegate
                    self.navigationController?.pushViewController(shopVC, animated: true)
                } else {
                    Alert.showAlert(vc: self,
                                    message: "Server error",
                                    title: "Something went wrong",
                                    alertType: .serverErrorAlert,
                                    complition: {})
                }
            })
        }
    }
    
    @objc func regUser() {
        view.endEditing(true)
        guard
            let login = mainView.loginTextField.text,
            let password = mainView.passwordTextField.text else { return }
        
        (login != "" && password != "") ? mainView.loginButton.pulsate() : mainView.loginButton.shake()
        networkDelegate?.regUser(login: login, password: password) { isUidAvailable in
            if isUidAvailable {
                let shopVC = ShopViewController()
                shopVC.networkDelegate = self.networkDelegate
                self.navigationController?.pushViewController(shopVC, animated: true)
            }
        }
    }
    
    @objc private func accountOwningButtonPressed() {
        switch state {
        case .reg:
            SignState.shared.state = .login
            state = .login
        case .login:
            SignState.shared.state = .reg
            state = .reg
        }
        userLoginVCDelegate?
            .setStateForLoginButton(buttons: [mainView.accountOwningButton,
                                              mainView.loginButton],
                                    vc: self)
    }
    
    @objc private func forgotPassButtonPressed() {
        networkDelegate?.forgotUserPassword(login: mainView.loginTextField.text ?? "")
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillShow(notification: notification,
                                              viewController: self)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillHide(notification: notification,
                                              viewController: self)
    }
}

