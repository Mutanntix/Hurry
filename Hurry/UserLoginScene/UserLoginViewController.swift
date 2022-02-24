//
//  ViewController.swift
//  Hurry
//
//  Created by Мурад on 21.02.2022.
//

import UIKit

class UserLoginViewController: UIViewController, UITextFieldDelegate {
    
    let mainView = UIView()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginLabel = UILabel()
    let passwordLabel = UILabel()
    let loginButton = UIButton()
    let accountOwningButton = UIButton()
    let forgotPasswordButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializate()
        setupConstraints()
        print(self.view.frame.width)
    }

    private func initializate() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        setupMainView()
        setupLabels()
        setupTextFields()
        
        view.addSubview(mainView)

        mainView.addSubview(loginTextField)
        mainView.addSubview(passwordTextField)
        mainView.addSubview(loginLabel)
    

    }
    
    private func setupConstraints() {
        // mainView contstraints
        mainView.snp.makeConstraints { make in
            let height = self.view.frame.size.height * 0.8
            let width = self.view.frame.size.width * 0.8
            
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        loginTextField.snp.makeConstraints { make in
            let width = self.mainView.frame.width
            let height = self.mainView.frame.size.height
            
            make.height.equalTo(40)
            make.width.equalTo(150)
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            let width = self.mainView.layer.frame.width * 0.8
            
            make.height.equalTo(40)
            print(width)
            make.width.equalTo(150)
            make.top.equalToSuperview().inset(0)
            make.left.equalToSuperview().inset(0)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(60)
        }
    }
    
    private func setupMainView() {
        mainView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        mainView.layer.cornerRadius = 20
        
        mainView.layer.shadowRadius = 10
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shouldRasterize = true
        mainView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupTextFields() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Title *"
        loginTextField.layer.borderColor = UIColor.black.cgColor
        loginTextField.layer.borderWidth = 2
        loginTextField.layer.cornerRadius = 15
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.font = UIFont.systemFont(ofSize: 13)
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    
        
        passwordTextField.placeholder = "Enter your password"
        loginTextField.layer.cornerRadius = 15
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupLabels() {
        loginLabel.text = ""
        loginLabel.font = UIFont.systemFont(ofSize: 25)
    }
}

