//
//  UserLoginView.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 05.04.2022.
//

import Foundation
import UIKit

class UserLoginView: UIView {
    
    let enterUserImage = UIImage(named: "enterUser")
    
    let mainView = UIView()
    let footerView = UIView()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let accountOwningButton = UIButton()
    let forgotPasswordButton = UIButton()
    let privacyPolicyButton = UIButton()
    let textFieldsStackView = UIStackView()
    let buttonsStackView = UIStackView()
    let welcomeLabel = UILabel()
    let enterUserImageView = UIImageView()
    let footerButton = UIButton()
    let footerLabel = UILabel()
    let footerTopBorder = UIView()

    var userLoginVCDelegate: UserloginViewControllerProtocol?
    var isLargeScreen: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isLargeScreen = self.isLargeScreen(frame: frame)
        self.setupUserLoginMainView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Setup Main View
    private func setupUserLoginMainView() {
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.addSubview(mainView)
        self.addSubview(footerView)
        mainView.addSubview(enterUserImageView)
        mainView.addSubview(welcomeLabel)
        mainView.addSubview(textFieldsStackView)
        mainView.addSubview(buttonsStackView)
        footerView.addSubview(footerButton)
        footerView.addSubview(footerLabel)
        footerView.addSubview(footerTopBorder)
        
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        buttonsStackView.addArrangedSubview(privacyPolicyButton)
        buttonsStackView.addArrangedSubview(loginButton)
        buttonsStackView.addArrangedSubview(accountOwningButton)
        buttonsStackView.addArrangedSubview(forgotPasswordButton)
        
        mainView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        mainView.layer.cornerRadius = 20

        mainView.layer.shadowRadius = 10
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shouldRasterize = true
        mainView.layer.rasterizationScale = UIScreen.main.scale
        
        footerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        footerLabel.text = "marc1k3y && mutanntix"
        footerLabel.font = UIFont.boldSystemFont(ofSize: 13)
        footerLabel.textAlignment = .right
        
        footerTopBorder.backgroundColor = .black
    
        let attributedStringForFooterButton = NSAttributedString(string: NSLocalizedString("buy coffee author", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0),
            NSAttributedString.Key.foregroundColor: UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1),
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        footerButton.setAttributedTitle(attributedStringForFooterButton, for: .normal)
        footerButton.contentHorizontalAlignment = .left
        
        enterUserImageView.image = enterUserImage
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .center
        textFieldsStackView.spacing = isLargeScreen ? 25 : 15
        textFieldsStackView.distribution = .fillEqually
        
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = isLargeScreen ? 15 : 10
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        
        loginTextField.placeholder = "Enter your login"
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.autocapitalizationType = .none
        loginTextField.layer.borderWidth = 1.5
        loginTextField.layer.cornerRadius = 20
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.font = UIFont.systemFont(ofSize: 15)
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginTextField.textContentType = .username
    
        
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        
        loginButton.backgroundColor = UIColor(red: 37/255, green: 159/255, blue: 237/255, alpha: 1)
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        loginButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        let attributedStringForAccountButton = NSAttributedString(string: NSLocalizedString("I don't have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        accountOwningButton.setAttributedTitle(attributedStringForAccountButton, for: .normal)
        
        let attributedStringForPrivacyButton = NSAttributedString(string: NSLocalizedString("privacy polity", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        privacyPolicyButton.setAttributedTitle(attributedStringForPrivacyButton, for: .normal)
        
        let attributedStringForForgotPasswordButton = NSAttributedString(string: NSLocalizedString("forgot password", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        forgotPasswordButton.setAttributedTitle(attributedStringForForgotPasswordButton, for: .normal)
        
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        welcomeLabel.textAlignment = .center
    }
    
    //MARK: -Setup Constraints
    private func setupConstraints() {
        let width = self.frame.width
        let height = self.frame.height
        
        mainView.snp.makeConstraints { make in
            let height = isLargeScreen ? self.frame.size.height * 0.7 : self.frame.size.height * 0.75
            let width = self.frame.size.width * 0.8
            
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerY.centerX.equalToSuperview()
        }
        
        footerView.snp.makeConstraints { make in
            let height = isLargeScreen ? self.frame.size.height * 0.1 : self.frame.size.height * 0.08
            
            make.height.equalTo(height)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        enterUserImageView.snp.makeConstraints { make in
            if isLargeScreen {
                make.height.width.equalTo(height / 5)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(5)
            } else {
                make.height.width.equalTo(height / 5)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(20)
            }
        }
        
        welcomeLabel.snp.makeConstraints { make in
            if isLargeScreen {
                welcomeLabel.font = UIFont.boldSystemFont(ofSize: 35)
                make.height.equalTo(height / 12)
                make.width.equalTo(width / 2)
                
                make.centerX.equalToSuperview()
                make.bottom.equalTo(loginTextField).inset(50)
            } else {
                welcomeLabel.font = UIFont.boldSystemFont(ofSize: 25)
                make.height.equalTo(height / 15)
                make.width.equalTo(width / 2)
                
                make.centerX.equalToSuperview()
                make.bottom.equalTo(loginTextField).inset(45)
            }
        }
        
        textFieldsStackView.snp.makeConstraints { make in

            if isLargeScreen {
                make.height.equalTo(height * 0.15)
                make.top.equalToSuperview().inset((height * 0.8) / 3)
            } else {
                make.height.equalTo(height * 0.15)
                make.top.equalToSuperview().inset((height * 0.8) / 2.5)
            }
            
            make.width.equalTo(width * 0.75)
            make.centerX.equalToSuperview()
            
        }
        
        buttonsStackView.snp.makeConstraints { make in

            if isLargeScreen {
                make.height.equalTo(height * 0.2)
                make.bottom.equalToSuperview().inset(20)
            } else {
                make.height.equalTo(height * 0.2)
                make.bottom.equalToSuperview().inset(10)
            }
            
            make.width.equalTo(width * 0.75)
            make.centerX.equalToSuperview()
            
        }
     
        loginTextField.snp.makeConstraints { make in
            make.width.equalTo(width * 0.7)
            make.centerX.equalToSuperview()
            
            
        }

        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(width * 0.7)
            make.centerX.equalToSuperview()
            

        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            if isLargeScreen {
                make.height.equalTo(50)
                make.width.equalTo(width * 0.3)
                loginButton.layer.cornerRadius = 23
            } else {
                make.height.equalTo(30)
                make.width.equalTo(width * 0.2)
                loginButton.layer.cornerRadius = 15
            }
            
        }
        
        accountOwningButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(15)
            make.width.equalTo(width * 0.6)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(15)
            make.width.equalTo(width * 0.6)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(15)
            make.width.equalTo(width * 0.6)
        }
      
        footerButton.snp.makeConstraints { make in
            make.width.equalTo(width / 2.5)
            make.height.equalTo(height * (isLargeScreen ? 0.1 : 0.08))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(isLargeScreen ? 15 : 10)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 2.2)
            make.height.equalTo(height * (isLargeScreen ? 0.1 : 0.08))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(isLargeScreen ? 15 : 10)
        }
        
        footerTopBorder.snp.makeConstraints { make in
            make.bottom.equalTo(footerView.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}


extension UserLoginView {
    private func isLargeScreen(frame: CGRect) -> Bool {
        return frame.height > 670 ? true : false
    }
}
