//
//  ViewController.swift
//  Hurry
//
//  Created by Мурад on 21.02.2022.
//

import UIKit
import SnapKit
import Alamofire

protocol UserloginViewControllerProtocol {
    func keyboardWillShow(notification: NSNotification, viewController: UIViewController)
    func keyboardWillHide(notification: NSNotification, viewController: UIViewController)
    func changeTitleForLoginButton(buttons: [UIButton], vc: UIViewController)
}

class UserLoginViewController: UIViewController, UITextFieldDelegate {
    
    let mainView = UIView()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginLabel = UILabel()
    let passwordLabel = UILabel()
    let loginButton = UIButton()
    let accountOwningButton = UIButton()
    let forgotPasswordButton = UIButton()
    let privacyPolicyButton = UIButton()
    let textFieldsStackView = UIStackView()
    let buttonsStackView = UIStackView()
    let welcomeLabel = UILabel()

    var userLoginVCDelegate: UserloginViewControllerDelegate?
    var isLargeScreen: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLargeScreen = isLargeScreen(viewController: self)
        print(isLargeScreen as Any)
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        userLoginVCDelegate = UserloginViewControllerDelegate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        initializate()
        setupConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        getUserData()
        return true
    }

    private func initializate() {
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        setupMainView()
        setupWelcomeLabel()
        setupStackViews()
        
        view.addSubview(mainView)
        
        mainView.addSubview(welcomeLabel)
        mainView.addSubview(textFieldsStackView)
        mainView.addSubview(buttonsStackView)
    }
    
    //MARK: CONSTRAINTS
    
    private func setupConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        
        // mainView contstraints
        mainView.snp.makeConstraints { make in
            let height = isLargeScreen ? self.view.frame.size.height * 0.7 : self.view.frame.size.height * 0.75
            let width = self.view.frame.size.width * 0.8
            
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            if isLargeScreen {
                welcomeLabel.font = UIFont.boldSystemFont(ofSize: 35)
                make.height.equalTo(height / 12)
                make.width.equalTo(width / 2)
                
                make.centerX.equalToSuperview()
                make.bottom.equalTo(loginTextField).inset(60)
            } else {
                welcomeLabel.font = UIFont.boldSystemFont(ofSize: 25)
                make.height.equalTo(height / 15)
                make.width.equalTo(width / 2)
                
                make.centerX.equalToSuperview()
                make.bottom.equalTo(loginTextField).inset(50)
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
      
    }
    
    //MARK: SETUP VIEWS
    
    private func setupMainView() {
        mainView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        mainView.layer.cornerRadius = 20
        
        mainView.layer.shadowRadius = 10
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shouldRasterize = true
        mainView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupStackViews() {
       // setupLabels()
        setupTextFields()
        setupButtons()
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.alignment = .center
        textFieldsStackView.spacing = isLargeScreen ? 25 : 15
        textFieldsStackView.distribution = .fillEqually
        
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = isLargeScreen ? 15 : 10
        buttonsStackView.distribution = .equalSpacing
        
        buttonsStackView.addArrangedSubview(privacyPolicyButton)
        buttonsStackView.addArrangedSubview(loginButton)
        buttonsStackView.addArrangedSubview(accountOwningButton)
        buttonsStackView.addArrangedSubview(forgotPasswordButton)
        buttonsStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        
//        textFieldsStackView.backgroundColor = .lightGray
//        buttonsStackView.backgroundColor = .lightGray
        
    }
    
    private func setupTextFields() {
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
        
    }
    
    
    private func setupButtons() {
        loginButton.backgroundColor = UIColor(red: 37/255, green: 159/255, blue: 237/255, alpha: 1)
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        loginButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        loginButton.addTarget(self, action: #selector(getUserData), for:.touchUpInside)
        
        let attributedStringForAccountButton = NSAttributedString(string: NSLocalizedString("I don't have an account", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        accountOwningButton.setAttributedTitle(attributedStringForAccountButton, for: .normal)
        accountOwningButton.addTarget(self, action: #selector(changeTitleForLoginButton), for: .touchUpInside)
        
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
        
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        welcomeLabel.textAlignment = .center
    }

    
    
    
    
    //MARK: CONTROLLER METHODS
    
    @objc private func getUserData() {
        view.endEditing(true)
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        
        (login != "" && password != "") ? loginButton.pulsate() : loginButton.shake()
        NetworkManager.shared.getUserData(from: login, password: password)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillShow(notification: notification, viewController: self)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillHide(notification: notification, viewController: self)
    }
    
    @objc private func changeTitleForLoginButton() {
        userLoginVCDelegate?.changeTitleForLoginButton(buttons: [accountOwningButton, loginButton], vc: self)
    }
}


extension UIButton {
    func pulsate() {

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        layer.add(pulse, forKey: "pulse")
    }
    
    func shake() {

        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: "position")
    }
}


extension UserLoginViewController {
    fileprivate func isLargeScreen(viewController: UIViewController) -> Bool {
        guard let userVC = viewController as? UserLoginViewController else { return false }
        
        return userVC.view.frame.height > 670 ? true : false
    }
}
