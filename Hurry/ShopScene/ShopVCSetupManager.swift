//
//  ShopVCSetupManager.swift
//  Hurry
//
//  Created by Мурад on 08.03.2022.
//

import Foundation
import UIKit
import SnapKit

class ShopVCSetupManager {
    
    static let shared = ShopVCSetupManager()
    
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
    
    private init() { }
    
    //MARK: SETUP HEADER VIEW
    func setupShopVCHeader(viewController: ShopViewController) {
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
        
        headerGoToShopButton.addSubview(bottomBorderView)
        
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
        
        // header image view
        headerImageView.image = UIImage(named: "hurry2")
        
        // settings button
        headerSettingsButton.setImage(UIImage(named: "settings"), for: .normal)
        headerSettingsButton.addTarget(viewController, action: #selector(viewController.goToUserAdminVC), for: .touchUpInside)
        
        // bottom border for the settings button
        bottomBorderView.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        
        
        headerView.addSubview(headerLabelStackView)
        headerView.addSubview(headerButtonsStackView)
        headerView.addSubview(headerBorder)
        
        viewController.view.addSubview(headerView)
        
        //MARK: SETUP HEADER VIEW CONSTRAINTS
        headerView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(viewController.view.frame.height / 10)
            make.top.equalToSuperview()
            
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
    
    @objc private func goToUserAdminVC(viewController: UIViewController) {
        guard let userAdminVC = viewController as? UserAdminViewController else { return }
        
        userAdminVC.navigationController?.popViewController(animated: false)
    }
}

extension ShopVCSetupManager {
    func isLargeScreen(viewController: UIViewController) -> Bool {
        guard let shopVC = viewController as? ShopViewController else { return false }
        
        return shopVC.view.frame.height > 670 ? true : false
    }
}
