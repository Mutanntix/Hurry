//
//  SetupSubViewsDelegate.swift
//  Hurry
//
//  Created by Мурад on 01.03.2022.
//

import Foundation
import UIKit

class UserVCSetupManager {
    
    public static func setupUserLoginVCViews(viewController: UserLoginViewController, isLargeScreen: Bool) {
        
        //MARK: SETUP MAIN VIEW
        viewController.mainView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        viewController.mainView.layer.cornerRadius = 20

        viewController.mainView.layer.shadowRadius = 10
        viewController.mainView.layer.shadowOpacity = 0.2
        viewController.mainView.layer.shouldRasterize = true
        viewController.mainView.layer.rasterizationScale = UIScreen.main.scale
        
        //MARK: SETUP FOOTER VIEW
        viewController.footerView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        viewController.addTopBorder(with: .black, andWidth: 1, view: viewController.footerView)
        
        //MARK: SETUP FOOTER VIEW ELEMENTS
        viewController.footerLabel.text = "marc1k3y && mutanntix"
        viewController.footerLabel.font = UIFont.boldSystemFont(ofSize: 13)
        viewController.footerLabel.textAlignment = .right
    
        let attributedStringForFooterButton = NSAttributedString(string: NSLocalizedString("buy coffee author", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0),
            NSAttributedString.Key.foregroundColor: UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1),
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        viewController.footerButton.setAttributedTitle(attributedStringForFooterButton, for: .normal)
        viewController.footerButton.contentHorizontalAlignment = .left
        
        viewController.footerView.addSubview(viewController.footerButton)
        viewController.footerView.addSubview(viewController.footerLabel)
        
        //MARK: SETUP IMAGE VIEW
        viewController.enterUserImageView.image = viewController.enterUserImage
        
        //MARK: SETUP STACK VIEWS
        viewController.textFieldsStackView.axis = .vertical
        viewController.textFieldsStackView.alignment = .center
        viewController.textFieldsStackView.spacing = isLargeScreen ? 25 : 15
        viewController.textFieldsStackView.distribution = .fillEqually
        
        viewController.textFieldsStackView.addArrangedSubview(viewController.loginTextField)
        viewController.textFieldsStackView.addArrangedSubview(viewController.passwordTextField)
        
        viewController.buttonsStackView.axis = .vertical
        viewController.buttonsStackView.alignment = .center
        viewController.buttonsStackView.spacing = isLargeScreen ? 15 : 10
        viewController.buttonsStackView.distribution = .equalSpacing
        
        viewController.buttonsStackView.addArrangedSubview(viewController.privacyPolicyButton)
        viewController.buttonsStackView.addArrangedSubview(viewController.loginButton)
        viewController.buttonsStackView.addArrangedSubview(viewController.accountOwningButton)
        viewController.buttonsStackView.addArrangedSubview(viewController.forgotPasswordButton)
        viewController.buttonsStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        
        //MARK: SETUP TEXT FIELDS
        
        viewController.loginTextField.placeholder = "Enter your login"
        viewController.loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: viewController.loginTextField.frame.height))
        viewController.loginTextField.leftViewMode = .always
        viewController.loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        viewController.loginTextField.autocapitalizationType = .none
        viewController.loginTextField.layer.borderWidth = 1.5
        viewController.loginTextField.layer.cornerRadius = 20
        viewController.loginTextField.keyboardType = UIKeyboardType.default
        viewController.loginTextField.returnKeyType = UIReturnKeyType.done
        viewController.loginTextField.autocorrectionType = UITextAutocorrectionType.no
        viewController.loginTextField.font = UIFont.systemFont(ofSize: 15)
        viewController.loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        viewController.loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewController.loginTextField.textContentType = .username
    
        
        viewController.passwordTextField.placeholder = "Enter your password"
        viewController.passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: viewController.loginTextField.frame.height))
        viewController.passwordTextField.leftViewMode = .always
        viewController.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        viewController.passwordTextField.autocapitalizationType = .none
        viewController.passwordTextField.layer.borderWidth = 1.5
        viewController.passwordTextField.layer.cornerRadius = 20
        viewController.passwordTextField.keyboardType = UIKeyboardType.default
        viewController.passwordTextField.returnKeyType = UIReturnKeyType.done
        viewController.passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        viewController.passwordTextField.font = UIFont.systemFont(ofSize: 15)
        viewController.passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        viewController.passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewController.passwordTextField.isSecureTextEntry = true
        viewController.passwordTextField.textContentType = .password
        
        //MARK: SETUP BUTTONS
        viewController.loginButton.backgroundColor = UIColor(red: 37/255, green: 159/255, blue: 237/255, alpha: 1)
        viewController.loginButton.setTitle("Sign in", for: .normal)
        viewController.loginButton.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        viewController.loginButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        
        let attributedStringForAccountButton = NSAttributedString(string: NSLocalizedString("I don't have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        viewController.accountOwningButton.setAttributedTitle(attributedStringForAccountButton, for: .normal)
        
        let attributedStringForPrivacyButton = NSAttributedString(string: NSLocalizedString("privacy polity", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        viewController.privacyPolicyButton.setAttributedTitle(attributedStringForPrivacyButton, for: .normal)
        
        let attributedStringForForgotPasswordButton = NSAttributedString(string: NSLocalizedString("forgot password", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        viewController.forgotPasswordButton.setAttributedTitle(attributedStringForForgotPasswordButton, for: .normal)
        
        //MARK: SETUP WELCOME LABEL
        viewController.welcomeLabel.text = "Welcome!"
        viewController.welcomeLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        viewController.welcomeLabel.textAlignment = .center
    
    
    //MARK: SETUP SUBVIEWS FOR MAIN VIEW
        viewController.mainView.addSubview(viewController.enterUserImageView)
        viewController.mainView.addSubview(viewController.welcomeLabel)
        viewController.mainView.addSubview(viewController.textFieldsStackView)
        viewController.mainView.addSubview(viewController.buttonsStackView)
    }

}

