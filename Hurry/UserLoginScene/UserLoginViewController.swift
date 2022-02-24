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
    let userLoginStackView = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        initializate()
        setupConstraints()
        
    }

    private func initializate() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        setupMainView()
        setupStackView()
        
        view.addSubview(mainView)
        
        mainView.addSubview(userLoginStackView)
    }
    
    private func setupConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        
        // mainView contstraints
        mainView.snp.makeConstraints { make in
            let height = self.view.frame.size.height * 0.8
            let width = self.view.frame.size.width * 0.8
            
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        userLoginStackView.snp.makeConstraints { make in

            if view.frame.size.height <= 667 {
                make.height.equalTo(height * 0.2)
            } else { make.height.equalTo(height * 0.15) }
            
            make.width.equalTo(width * 0.75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset((height * 0.8) / 1.8)
        }
     
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(width * 0.7)
            make.centerX.equalToSuperview()
            
            
        }

        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(width * 0.7)
            make.centerX.equalToSuperview()
            

        }

        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(-28)

            make.height.equalTo(30)
            make.width.equalTo(85)
        }

        passwordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(-28)

            make.height.equalTo(30)
            make.width.equalTo(85)
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
    
    private func setupStackView() {
        setupLabels()
        setupTextFields()
        
        userLoginStackView.axis = .vertical
        userLoginStackView.alignment = .center
        userLoginStackView.spacing = 25
        userLoginStackView.distribution = .equalSpacing
        
        userLoginStackView.addArrangedSubview(loginTextField)
        userLoginStackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupTextFields() {
        loginTextField.placeholder = "Enter your login"
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.layer.borderWidth = 1.5
        loginTextField.layer.cornerRadius = 15
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.font = UIFont.systemFont(ofSize: 15)
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginTextField.addSubview(loginLabel)
    
        
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addSubview(passwordLabel)
        
    }
    
    private func setupLabels() {
        loginLabel.text = "Login"
        loginLabel.font = UIFont.systemFont(ofSize: 18)
        loginLabel.textAlignment = .center
        
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 18)
        passwordLabel.textAlignment = .center
    }
}

