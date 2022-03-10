//
//  UserAdminVCSetupManager.swift
//  Hurry
//
//  Created by Мурад on 04.03.2022.
//

import Foundation
import UIKit
import SnapKit

protocol UserAdminViewControllerProtocol: AnyObject {
    func saveChanges(view: UIView, button: UIButton)
    func connectTelegram(button: UIButton)
    func openChangePasswordVC(button: UIButton)
    func logout(button: UIButton)
}

class UserAdminVCSetupManager {
    
    static let shared = UserAdminVCSetupManager()
    
    var delegate: UserAdminViewControllerProtocol?
    
    //header view
    let headerView = UIView()
    let headerBorder = UIView()
    
    let headerLabelStackView = UIStackView()
    let headerButtonsStackView = UIStackView()
    
    let headerLabel = UILabel()
    let headerImageView = UIImageView()
    let headerChangeLangButton = UIButton()
    let headerGoToShopButton = UIButton()
    let headerSettingsButton = UIButton()
    let bottomBorderView = UIView()
    
    //main scroll view
    let mainScrollView = UIScrollView()
    
    //text fields and etc
    let textFieldsStackView = UIStackView()
    let nickNameTF = UITextField()
    let favoriteDrinkTF = UITextField()
    let countryTF = UITextField()
    let cityTF = UITextField()
    
    let nickNameLabel = UILabel()
    let favoriteDrinkLabel = UILabel()
    let countryLabel = UILabel()
    let cityLabel = UILabel()
    
    let mainView = UIView()
    let profileInfoLabel = UILabel()
    let saveButton = UIButton()
    let connectLabel = UILabel()
    let connectButton = UIButton()
    
    let changePasswordView = UIView()
    let changePasswordButton = UIButton()
    let logoutButton = UIButton()
    
    let savingView = UIView()
    let savingViewLabel = UILabel()
    
    private init() {
        self.delegate = UserAdminViewControllerDelegate()
    }
    
    
    //MARK: SETUP HEADER VIEW
    func setupUserAdminVCHeader(viewController: UserAdminViewController) {
        let isLargeScreen = self.isLargeScreen(viewController: viewController)
        
        headerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        headerBorder.backgroundColor = .black
        
        //MARK: SETUP STACK VIEWS
        headerLabelStackView.addArrangedSubview(headerLabel)
        headerLabelStackView.addArrangedSubview(headerImageView)
        headerLabelStackView.axis = .horizontal
        headerLabelStackView.spacing = 5
        
        headerButtonsStackView.addArrangedSubview(headerChangeLangButton)
        headerButtonsStackView.addArrangedSubview(headerGoToShopButton)
        headerButtonsStackView.addArrangedSubview(headerSettingsButton)
        headerButtonsStackView.contentMode = .right
        headerButtonsStackView.distribution = .equalSpacing
        headerButtonsStackView.axis = .horizontal
        headerButtonsStackView.spacing = 15
        
        headerSettingsButton.addSubview(bottomBorderView)
        
        //MARK: SETUP STACK VIEWS SUBVIEWS
        headerLabel.text = "hurry"
        headerLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        headerLabel.textAlignment = .left
        headerLabel.attributedText = NSAttributedString(string: NSLocalizedString("hurry", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: (isLargeScreen ? 26 : 24)),
            NSAttributedString.Key.underlineStyle: 1.0,
        ])
        
        
        // change lang button
        headerChangeLangButton.setTitle("en", for: .normal)
        headerChangeLangButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        headerChangeLangButton.setTitleColor(UIColor.black, for: .normal)
        headerChangeLangButton.layer.borderWidth = 1
        headerChangeLangButton.layer.cornerRadius = 5
        headerChangeLangButton.contentHorizontalAlignment = .center
        
        // go to shop page button
        headerGoToShopButton.setImage(UIImage(named: "shop"), for: .normal)
        headerGoToShopButton.contentHorizontalAlignment = .center
        headerGoToShopButton.addTarget(viewController, action: #selector(viewController.goToShopVC), for: .touchUpInside)
        
        // header image view
        headerImageView.image = UIImage(named: "hurry2")
        
        // settings button
        headerSettingsButton.setImage(UIImage(named: "settings"), for: .normal)
        
        // bottom border for the settings button
        bottomBorderView.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        
        
        headerView.addSubview(headerLabelStackView)
        headerView.addSubview(headerButtonsStackView)
        headerView.addSubview(headerBorder)
        
        viewController.view.addSubview(headerView)
        
        //MARK: SETUP HEADER VIEW CONSTRAINTS
        headerView.snp.makeConstraints { make in
            make.height.equalTo(viewController.view.frame.height / 10)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(0)
        }
        
        headerBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
        
        headerLabelStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(isLargeScreen ? 20 : 15)
        }
        
        headerButtonsStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(isLargeScreen ? 20 : 15)
            
        }
        
        headerGoToShopButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        headerImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
        }

        headerChangeLangButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }

        headerSettingsButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        bottomBorderView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(2)
            make.bottom.equalToSuperview().inset(-5)
        }
    }
    
    //MARK: SETUP MAIN SCROLL VIEW
    func setupUserAdminVCMainView(viewController: UserAdminViewController) {
        let isLargeScreen = self.isLargeScreen(viewController: viewController)

        let width = viewController.view.frame.size.width
        let height = viewController.view.frame.size.height
        
        nickNameTF.delegate = viewController
        favoriteDrinkTF.delegate = viewController
        countryTF.delegate = viewController
        cityTF.delegate = viewController
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .center
        textFieldsStackView.spacing = isLargeScreen ? 40 : 30
        textFieldsStackView.distribution = .fillEqually
        
        textFieldsStackView.addArrangedSubview(nickNameTF)
        textFieldsStackView.addArrangedSubview(favoriteDrinkTF)
        textFieldsStackView.addArrangedSubview(countryTF)
        textFieldsStackView.addArrangedSubview(cityTF)
        
        nickNameTF.addSubview(nickNameLabel)
        favoriteDrinkTF.addSubview(favoriteDrinkLabel)
        countryTF.addSubview(countryLabel)
        cityTF.addSubview(cityLabel)
        
        mainView.addSubview(textFieldsStackView)
        
        // setup nickName text field
        nickNameTF.placeholder = "Enter your nickname"
        nickNameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nickNameTF.frame.height))
        nickNameTF.leftViewMode = .always
        nickNameTF.layer.borderColor = UIColor.lightGray.cgColor
        nickNameTF.autocapitalizationType = .none
        nickNameTF.layer.borderWidth = 1.5
        nickNameTF.layer.cornerRadius = 10
        nickNameTF.keyboardType = UIKeyboardType.default
        nickNameTF.returnKeyType = UIReturnKeyType.done
        nickNameTF.autocorrectionType = UITextAutocorrectionType.no
        nickNameTF.font = UIFont.systemFont(ofSize: 15)
        nickNameTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        nickNameTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nickNameTF.textContentType = .username
        
        // setup favorite drink text field
        favoriteDrinkTF.placeholder = "Enter your favorite drink"
        favoriteDrinkTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nickNameTF.frame.height))
        favoriteDrinkTF.leftViewMode = .always
        favoriteDrinkTF.layer.borderColor = UIColor.lightGray.cgColor
        favoriteDrinkTF.autocapitalizationType = .none
        favoriteDrinkTF.layer.borderWidth = 1.5
        favoriteDrinkTF.layer.cornerRadius = 10
        favoriteDrinkTF.keyboardType = UIKeyboardType.default
        favoriteDrinkTF.returnKeyType = UIReturnKeyType.done
        favoriteDrinkTF.autocorrectionType = UITextAutocorrectionType.no
        favoriteDrinkTF.font = UIFont.systemFont(ofSize: 15)
        favoriteDrinkTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        favoriteDrinkTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        favoriteDrinkTF.textContentType = .username
        
        //setup country text field
        countryTF.placeholder = "Enter your country"
        countryTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nickNameTF.frame.height))
        countryTF.leftViewMode = .always
        countryTF.layer.borderColor = UIColor.lightGray.cgColor
        countryTF.autocapitalizationType = .none
        countryTF.layer.borderWidth = 1.5
        countryTF.layer.cornerRadius = 10
        countryTF.keyboardType = UIKeyboardType.default
        countryTF.returnKeyType = UIReturnKeyType.done
        countryTF.autocorrectionType = UITextAutocorrectionType.no
        countryTF.font = UIFont.systemFont(ofSize: 15)
        countryTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        countryTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        countryTF.textContentType = .username
        
        //setup city text field
        cityTF.placeholder = "Enter your city"
        cityTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nickNameTF.frame.height))
        cityTF.leftViewMode = .always
        cityTF.layer.borderColor = UIColor.lightGray.cgColor
        cityTF.autocapitalizationType = .none
        cityTF.layer.borderWidth = 1.5
        cityTF.layer.cornerRadius = 10
        cityTF.keyboardType = UIKeyboardType.default
        cityTF.returnKeyType = UIReturnKeyType.done
        cityTF.autocorrectionType = UITextAutocorrectionType.no
        cityTF.font = UIFont.systemFont(ofSize: 15)
        cityTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        cityTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        cityTF.textContentType = .username
        
        //setup labels
        nickNameLabel.text = "Nickname"
        nickNameLabel.font = UIFont.systemFont(ofSize: isLargeScreen ? 18 : 16)
        
        //setup labels
        favoriteDrinkLabel.text = "Favorite drink"
        favoriteDrinkLabel.font = UIFont.systemFont(ofSize: isLargeScreen ? 18 : 16)
        
        //setup labels
        countryLabel.text = "Country"
        countryLabel.font = UIFont.systemFont(ofSize: isLargeScreen ? 18 : 16)
        
        //setup labels
        cityLabel.text = "City"
        cityLabel.font = UIFont.systemFont(ofSize: isLargeScreen ? 18 : 16)
        
        //setup constraints
        textFieldsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(isLargeScreen ? (height / 2.8) : (height / 2.3))
            make.width.equalTo(width / 1.7)
            make.bottom.equalToSuperview().inset(isLargeScreen ? 30 : 20)
        }
        
        nickNameTF.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        favoriteDrinkTF.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        countryTF.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        cityTF.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(nickNameTF.snp.height)
            make.left.equalTo(nickNameTF).inset(3)
            make.bottom.equalTo(nickNameTF.snp_topMargin)
        }
        
        favoriteDrinkLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(favoriteDrinkTF.snp.height)
            make.left.equalTo(favoriteDrinkTF).inset(3)
            make.bottom.equalTo(favoriteDrinkTF.snp_topMargin)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(countryTF.snp.height)
            make.left.equalTo(countryTF).inset(3)
            make.bottom.equalTo(countryTF.snp_topMargin)
        }
        
        cityLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(cityTF.snp.height)
            make.left.equalTo(cityTF).inset(3)
            make.bottom.equalTo(cityTF.snp_topMargin)
        }
        
        mainScrollView.addSubview(mainView)
        mainScrollView.addSubview(saveButton)
        mainScrollView.addSubview(connectLabel)
        mainScrollView.addSubview(connectButton)
        mainScrollView.addSubview(changePasswordView)
        mainScrollView.addSubview(savingView)
        
        savingView.addSubview(savingViewLabel)
        
        mainView.addSubview(profileInfoLabel)
        
        changePasswordView.addSubview(changePasswordButton)
        changePasswordView.addSubview(logoutButton)
        
        viewController.view.addSubview(mainScrollView)

        
        //MARK: SETUP SCROLL SUBVIEWS
        mainScrollView.contentSize = CGSize(width: width, height: isLargeScreen ? (height * 1.1) : (height * 1.2))
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.keyboardDismissMode = .onDrag
        
        mainView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        mainView.layer.cornerRadius = 20
        mainView.layer.shadowRadius = 10
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shouldRasterize = true
        mainView.layer.rasterizationScale = UIScreen.main.scale
        
        savingView.backgroundColor = .lightGray
        savingView.layer.borderWidth = 1
        savingView.layer.cornerRadius = 15
        savingView.isHidden = true
        
        savingViewLabel.text = "Done!"
        savingViewLabel.font = UIFont.boldSystemFont(ofSize: 35)
        savingViewLabel.textAlignment = .center
        savingViewLabel.textColor = .white
        
        profileInfoLabel.text = "Profile info"
        profileInfoLabel.font = UIFont.boldSystemFont(ofSize: isLargeScreen ? 30 : 25)
        profileInfoLabel.textAlignment = .center
        
        saveButton.backgroundColor = UIColor(red: 37/255, green: 159/255, blue: 237/255, alpha: 1)
        saveButton.layer.cornerRadius = isLargeScreen ? 23 : 16
        saveButton.setTitle("save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        
        connectLabel.text = "Connect with Telegram"
        connectLabel.font = UIFont.boldSystemFont(ofSize: 15)
        connectLabel.textAlignment = .center
        
        connectButton.setTitle("Connect", for: .normal)
        connectButton.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        connectButton.layer.cornerRadius = 12
        connectButton.addTarget(self, action: #selector(connectButtonPressed), for: .touchUpInside)

        changePasswordView.backgroundColor = .white
        changePasswordView.layer.cornerRadius = 15
        
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        changePasswordButton.layer.cornerRadius = 14
        changePasswordButton.addTarget(self, action: #selector(changePassButtonPressed), for: .touchUpInside)
        
        logoutButton.setTitle("log out", for: .normal)
        logoutButton.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        logoutButton.layer.cornerRadius = 14
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
                
        //MARK: SETUP SCROLL SUBVIEWS CONSTRAINTS
        
        mainScrollView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(0).offset(height / 10)
        }
        
        mainView.snp.makeConstraints { make in
            make.width.equalTo(width / 1.5)
            make.height.equalTo(isLargeScreen ? (height / 1.8) : (height / 1.5))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(isLargeScreen ? 50 : 30)
        }
        
        savingView.snp.makeConstraints { make in
            make.height.equalTo(width / 4)
            make.width.equalTo(width / 1.5)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(mainView)
        
        }
        
        savingViewLabel.snp.makeConstraints { make in
            make.height.equalTo(width / 6)
            make.width.centerY.centerX.equalToSuperview()
        }
        
        profileInfoLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 1.8)
            make.height.equalTo(isLargeScreen ? ((height / 1.8) / 10) : ((height / 1.5) / 10))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(isLargeScreen ? 30 : 20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(width / 1.6)
            make.height.equalTo(isLargeScreen ? 50 : 30)
            make.top.equalTo(mainView).inset(isLargeScreen ? ((height / 1.8) + 30) : ((height / 1.5) + 30))
            make.centerX.equalToSuperview()
        }
        
        connectLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainView).inset(isLargeScreen ? ((height / 1.8) + 100) : ((height / 1.5) + 80))
        }
        
        connectButton.snp.makeConstraints { make in
            make.width.equalTo(width / 4)
            make.height.equalTo(25)
            make.centerX.equalTo(mainScrollView)
            make.top.equalTo(connectLabel.snp_bottomMargin).inset(-5)
        }
        
        changePasswordView.snp.makeConstraints { make in
            make.width.equalTo(width / 1.6)
            make.height.equalTo(height / 8)
            make.centerX.equalToSuperview()
            make.top.equalTo(connectButton).inset(50)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.width.equalTo(changePasswordView.snp.width).inset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(changePasswordView.snp.width).inset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
    }
}

//MARK: BUTTONS ACTIONS
extension UserAdminVCSetupManager {
    @objc fileprivate func saveButtonPressed() {
        print("save button pressed")
        self.mainScrollView.endEditing(true)
        self.delegate?.saveChanges(view: self.savingView, button: self.saveButton)
    }

    @objc fileprivate func connectButtonPressed() {
        print("connect button pressed")
        self.delegate?.connectTelegram(button: self.connectButton)
    }
    
    @objc fileprivate func changePassButtonPressed() {
        print("change password button pressed")
        self.delegate?.openChangePasswordVC(button: self.changePasswordButton)
    }
    
    @objc fileprivate func logoutButtonPressed() {
        print("logout button pressed")
        self.delegate?.logout(button: self.logoutButton)
    }
    
    
}


extension UserAdminVCSetupManager {
    func isLargeScreen(viewController: UIViewController) -> Bool {
        guard let userVC = viewController as? UserAdminViewController else { return false }
        
        return userVC.view.frame.height > 670 ? true : false
    }
    
}

