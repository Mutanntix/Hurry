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
    let userLoginStackView = UIStackView()

    var userLoginVCDelegate: UserloginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        userLoginVCDelegate = UserloginViewControllerDelegate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        initializate()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
        setupStackView()
        
        view.addSubview(mainView)
        
        mainView.addSubview(userLoginStackView)
    }
    
    //MARK: CONSTRAINTS
    
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
                make.height.equalTo(height * 0.45)
            } else { make.height.equalTo(height * 0.35) }
            
            make.width.equalTo(width * 0.75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset((height * 0.8) / 2.4)
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
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(50)
            make.width.equalTo(width * 0.3)
        }
        
        accountOwningButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(35)
            make.width.equalTo(width * 0.6)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            
            make.height.equalTo(35)
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
    
    private func setupStackView() {
        setupLabels()
        setupTextFields()
        setupButtons()
        
        userLoginStackView.axis = .vertical
        userLoginStackView.alignment = .center
        userLoginStackView.spacing = 20
        userLoginStackView.distribution = .equalSpacing
        
        userLoginStackView.addArrangedSubview(loginTextField)
        userLoginStackView.addArrangedSubview(passwordTextField)
        userLoginStackView.addArrangedSubview(privacyPolicyButton)
        userLoginStackView.addArrangedSubview(loginButton)
        userLoginStackView.addArrangedSubview(accountOwningButton)
    }
    
    private func setupTextFields() {
        loginTextField.placeholder = "Enter your login"
        loginTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: loginTextField.frame.height))
        loginTextField.leftViewMode = .always
        loginTextField.layer.borderColor = UIColor.lightGray.cgColor
        loginTextField.autocapitalizationType = .none
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
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
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
    
    private func setupButtons() {
        loginButton.backgroundColor = UIColor(red: 37/255, green: 159/255, blue: 237/255, alpha: 1)
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.layer.cornerRadius = 23
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
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        privacyPolicyButton.setAttributedTitle(attributedStringForPrivacyButton, for: .normal)
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
