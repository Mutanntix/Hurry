//
//  UserAdminViewController.swift
//  Hurry
//
//  Created by Мурад on 04.03.2022.
//

import UIKit
import Foundation

protocol UserAdminKeyboardProtocol {
    func keyboardWillShow(notification: NSNotification,
                          viewController: UIViewController)
    
    func keyboardWillHide(notification: NSNotification,
                          viewController: UIViewController)
}

class UserAdminViewController: UIViewController,
                               UITextFieldDelegate {
    weak var networkDelegate: NetworkDelegate?
    
    var keyboardDelegate: UserAdminKeyboardProtocol?
    
    let pasteboard = UIPasteboard.general
    var currentUserInfoOffer: UserInfoOfferModel?
    
    var mainView: UserAdminMainView {
        return self.view as! UserAdminMainView
    }
    
    override func loadView() {
        self.view = UserAdminMainView(frame: UIScreen.main.bounds)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.keyboardDelegate = KeyboardDelegate()
        firstInitializate()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
        
    private func firstInitializate() {
        getAndUpdateUserInfo()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?
            .isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 245/255,
                                            green: 245/255,
                                            blue: 245/255,
                                            alpha: 1)
        
        self.mainView.cityTF.delegate = self
        self.mainView.countryTF.delegate = self
        self.mainView.nickNameTF.delegate = self
        self.mainView.favoriteDrinkTF.delegate = self
        
        self.mainView
            .headerGoToShopButton.addTarget(self,
                                            action: #selector(goToShopVC),
                                            for: .touchUpInside)
        
        self.mainView.saveButton.addTarget(self,
                                           action: #selector(saveButtonPressed),
                                           for: .touchUpInside)
        
        self.mainView.logoutButton.addTarget(self,
                                             action: #selector(logoutButtonPressed),
                                             for: .touchUpInside)
        
        self.mainView
            .changePasswordButton.addTarget(self,
                                            action: #selector(changePassButtonPressed),
                                            for: .touchUpInside)
        
        self.mainView
            .connectButton.addTarget(self,
                                     action: #selector(connectButtonPressed),
                                     for: .touchUpInside)
        
        self.mainView.connectTgView
            .goToBotButton.addTarget(self,
                                     action: #selector(goToBotButtonPressed),
                                     for: .touchUpInside)
        
        self.mainView.infoSavedView
            .doneButton.addTarget(self,
                                  action: #selector(doneButtonPressed),
                                  for: .touchUpInside)
    }
}

//MARK: -Methods
extension UserAdminViewController {
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillShow(notification: notification,
                                                viewController: self)
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        self.keyboardDelegate?.keyboardWillHide(notification: notification,
                                                viewController: self)
    }
    
    @objc func goToShopVC() {
        var shopVC: ShopViewController?
        guard let navigationController = self.navigationController
        else { return }
        
        for vc in navigationController.viewControllers {
            guard let attemptShopVC = vc as? ShopViewController
            else { continue }
            shopVC = attemptShopVC
        }
        guard let shopVC = shopVC else { return }

        self.navigationController?
            .popToViewController(shopVC,
                                 animated: false)
    }
    
    @objc fileprivate func saveButtonPressed() {
        mainView.saveButton
            .isEnabled = false
        mainView.mainScrollView.endEditing(true)
        
        pushNewUserInfo { [weak self] result in
            guard let newUserInfo = result
            else {
                Alert.showAlert(vc: self!,
                                message: "Something went wrong",
                                title: "Error",
                                alertType: .serverErrorAlert,
                                complition: {})
                self?.mainView.saveButton
                    .isEnabled = true
                return
            }
            self?.currentUserInfoOffer = newUserInfo
            self?.getAndUpdateUserInfo()
            self?.mainView.showSavedView { [weak self] in
                self?.mainView.saveButton
                    .isEnabled = true
            }
        }
    }

    @objc fileprivate func connectButtonPressed() {
        self.mainView.connectButton
            .isEnabled = false
        networkDelegate?.connectTelegram(
            complition: { [weak self] result in
                guard let result = result else { return }
                self?.pasteboard.string = result
            })

        mainView.showConnectTgView { [weak self] in
            self?.mainView
                .connectButton.isEnabled = true
        }
        
    }
    
    @objc fileprivate func changePassButtonPressed() {
        let changePassVC = ChangePassViewController()
        changePassVC.networkDelegate = self.networkDelegate
        self.present(
            UINavigationController(rootViewController: changePassVC),
            animated: true,
            completion: nil)
    }
    
    @objc fileprivate func logoutButtonPressed() {
        mainView.logoutButton.pulsate()
        Alert.showAlert(vc: self,
                        message: "Are you sure?",
                        title: "Do you want to logout?",
                        alertType: .logoutAlert,
                        complition: {})
    }
    
    @objc fileprivate func goToBotButtonPressed() {
        mainView.removeConnectTgView { [weak self] in
            self?.mainView
                .tgBlurView.removeFromSuperview()
            guard let url = URL(
                string: "https://t.me/hurry_orders_bot")
            else { return }
            UIApplication.shared.open(url)
        }
    }
    
    @objc fileprivate func doneButtonPressed() {
        mainView.removeSavedView { [weak self] in
            self?.mainView
                .infoBlurView.removeFromSuperview()
        }
    }
    
    private func getAndUpdateUserInfo() {
        networkDelegate?.getUserInfo(
            complition: { [weak self] userInfoOffer in
                guard let userInfoOffer = userInfoOffer
                else { return }
                self?.currentUserInfoOffer = userInfoOffer
                
                let userInfo = UserInfoModel(
                    offer: userInfoOffer)
                self?.mainView.updateTextFieldsFromModel(
                    userInfo: userInfo)
            })
    }
    
    private func pushNewUserInfo(
        complition: @escaping (UserInfoOfferModel?) -> Void) {
            guard let nick = mainView.nickNameTF.text,
                  let drink = mainView.favoriteDrinkTF.text,
                  let country = mainView.countryTF.text,
                  let city = mainView.cityTF.text
            else {
                complition(nil)
                return
            }
                
            guard let newUserInfo = currentUserInfoOffer?
                .updateUserInfo(nick: nick,
                                drink: drink,
                                contry: country,
                                city: city)
            else {
                complition(nil)
                return
            }
            networkDelegate?
                .updateUserInfo(userInfo: newUserInfo,
                                complition: { result in
                    complition(newUserInfo)
                })
    }
}

