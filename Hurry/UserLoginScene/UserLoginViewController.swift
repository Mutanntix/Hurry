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
    func keyboardWillShow(notification: NSNotification, viewController: UIViewController)
    func keyboardWillHide(notification: NSNotification, viewController: UIViewController)
    func changeTitleForLoginButton(buttons: [UIButton], vc: UIViewController)
}

class UserLoginViewController: UIViewController, UITextFieldDelegate {
    var isUserOnline = NetworkManager.shared.isConnected
    
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

    var userLoginVCDelegate: UserloginViewControllerProtocol?
    var isLargeScreen: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLargeScreen = isLargeScreen(viewController: self)
        
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
        
        UserVCSetupManager.setupUserLoginVCViews(viewController: self, isLargeScreen: isLargeScreen)
        accountOwningButton.addTarget(self, action: #selector(changeTitleForLoginButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(getUserData), for: .touchUpInside)
        
        view.addSubview(mainView)
        view.addSubview(footerView)
        
        
        
    }
    
    //MARK: CONSTRAINTS
    
    private func setupConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        
        mainView.snp.makeConstraints { make in
            let height = isLargeScreen ? self.view.frame.size.height * 0.7 : self.view.frame.size.height * 0.75
            let width = self.view.frame.size.width * 0.8
            
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        footerView.snp.makeConstraints { make in
            let height = isLargeScreen ? self.view.frame.size.height * 0.1 : self.view.frame.size.height * 0.08
            
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
    }
    
    
    //MARK: CONTROLLER METHODS
    
    @objc public func getUserData() {
        view.endEditing(true)
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        
        (login != "" && password != "") ? loginButton.pulsate() : loginButton.shake()
        NetworkManager.shared.loginUser(from: login, password: password) { isUidAvailable in
            if isUidAvailable {
                let shopVC = ShopViewController()
                self.navigationController?.pushViewController(shopVC, animated: true)
            }
        }
    }
    
    @objc public func keyboardWillShow(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillShow(notification: notification, viewController: self)
    }
    
    @objc public func keyboardWillHide(notification: NSNotification) {
        userLoginVCDelegate?.keyboardWillHide(notification: notification, viewController: self)
    }
    
    @objc public func changeTitleForLoginButton() {
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
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat, view: UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
}
