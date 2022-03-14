//
//  ForgotPassVC.swift
//  Hurry
//
//  Created by Мурад on 07.03.2022.
//

import UIKit

class ChangePassViewController: UIViewController {
    let changePassLabel = UILabel()
    let newPassTF = UITextField()
    let newPassAgainTf = UITextField()
    let doneButton = UIButton()
    var footerImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newPassTF.delegate = self
        newPassAgainTf.delegate = self
        
        firstInitializate()
        setupConstraints()
    }
}

extension ChangePassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveNewPass(mustAnimateButton: false)
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: SETUP VIEWS
    fileprivate func firstInitializate() {
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(barDoneButtonPressed))
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barCancelButtonPressed))
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(changePassLabel)
        view.addSubview(newPassTF)
        view.addSubview(newPassAgainTf)
        view.addSubview(doneButton)
        view.addSubview(footerImageView)
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        changePassLabel.text = "Do you want to change your password?"
        changePassLabel.font = UIFont.systemFont(ofSize: 20)
        changePassLabel.textAlignment = .center
        
        newPassTF.placeholder = "Enter new password"
        newPassTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newPassTF.frame.height))
        newPassTF.leftViewMode = .always
        newPassTF.layer.borderColor = UIColor.lightGray.cgColor
        newPassTF.autocapitalizationType = .none
        newPassTF.layer.borderWidth = 1.5
        newPassTF.layer.cornerRadius = 10
        newPassTF.keyboardType = UIKeyboardType.default
        newPassTF.returnKeyType = UIReturnKeyType.done
        newPassTF.autocorrectionType = UITextAutocorrectionType.no
        newPassTF.font = UIFont.systemFont(ofSize: 15)
        newPassTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        newPassTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        newPassTF.textContentType = .username
        
        newPassAgainTf.placeholder = "Enter new password again"
        newPassAgainTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newPassAgainTf.frame.height))
        newPassAgainTf.leftViewMode = .always
        newPassAgainTf.layer.borderColor = UIColor.lightGray.cgColor
        newPassAgainTf.autocapitalizationType = .none
        newPassAgainTf.layer.borderWidth = 1.5
        newPassAgainTf.layer.cornerRadius = 10
        newPassAgainTf.keyboardType = UIKeyboardType.default
        newPassAgainTf.returnKeyType = UIReturnKeyType.done
        newPassAgainTf.autocorrectionType = UITextAutocorrectionType.no
        newPassAgainTf.font = UIFont.systemFont(ofSize: 15)
        newPassAgainTf.clearButtonMode = UITextField.ViewMode.whileEditing;
        newPassAgainTf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        newPassAgainTf.textContentType = .username
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .lightGray
        doneButton.layer.cornerRadius = 15
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
        let image = UIImage(named: "product")
        footerImageView.image = image
    }
    
    //MARK: CONSTRAINTS
    fileprivate func setupConstraints() {
        let width = UIScreen.main.bounds.width
        
        changePassLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        
        newPassTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 1.2)
            make.height.equalTo(40)
            make.top.equalTo(changePassLabel.snp.bottom).offset(20)
        }
        
        newPassAgainTf.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 1.2)
            make.height.equalTo(40)
            make.top.equalTo(newPassTF.snp.bottom).offset(20)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(width / 1.2)
            make.height.equalTo(40)
            make.top.equalTo(newPassAgainTf.snp.bottom).offset(20)
        }
        
        footerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(width)
            make.centerX.equalTo(doneButton)
            make.top.equalTo(doneButton.snp.bottom).offset(50)
        }
    }
}

//MARK: METHODS
extension ChangePassViewController {
    @objc fileprivate func doneButtonPressed() {
        saveNewPass(mustAnimateButton: true)
    }
    
    @objc fileprivate func barDoneButtonPressed() {
        saveNewPass(mustAnimateButton: false)
        
    }

    @objc fileprivate func barCancelButtonPressed() {
        let warningAlert = UIAlertController(title: "Are you sure?", message: "Do you want to leave?", preferredStyle: .alert)
        warningAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        warningAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            //self.dismiss(animated: true, completion: nil)
        }))
        
        guard let newPass = newPassTF.text,
              let newPassAgain = newPassAgainTf.text, ((newPass != "") || (newPassAgain != ""))
        else {
            self.dismiss(animated: true) {
                //comlition
            }
            return
        }
        self.present(warningAlert, animated: true) {
            //complition
        }
        
    }
    
    fileprivate func saveNewPass(mustAnimateButton: Bool) {
        
        let okAlert = UIAlertController(title: "Done!", message: "Password was changed", preferredStyle: .alert)
        okAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        
        let alert = UIAlertController(title: "Error!", message: "Please, fill both text fields with similar passwords!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
            //self.dismiss(animated: true, completion: nil)
        }))
        
        guard let newPass = newPassTF.text,
              let newPassAgain = newPassAgainTf.text, ((newPass != "") && (newPassAgain != ""))
        else {
            if mustAnimateButton { doneButton.shake() }
            self.present(alert, animated: true, completion: nil)
            return
        }
        if newPass == newPassAgain {
            NetworkManager.shared.changeUserPassword(newPass: newPass)
            self.present(okAlert, animated: true, completion: nil)
            if mustAnimateButton { doneButton.pulsate() }
        } else {
            self.present(alert, animated: true, completion: nil)
            if mustAnimateButton { doneButton.pulsate() }
        }
    }
}
