//
//  ShopCardView.swift
//  Hurry
//
//  Created by Мурад on 12.03.2022.
//

import Foundation
import UIKit
import SnapKit

class ShopCardView: UIView {
    var currentShop: ShopModel?
    
    var isLargeScreen = true
    
    //MARK: HEADER VIEWS
    let headerView = UIView()
    let headerBorder = UIView()
    
    let headerLabelStackView = UIStackView()
    let headerButtonsStackView = UIStackView()
    
    let headerLabel = UILabel()
    let headerImageView = UIImageView()
    let headerChangeLangButton = UIButton()
    let headerGoToShopButton = UIButton()
    let headerSettingsButton = UIButton()
    
    //MARK: MAIN VIEWS
    let positionsCollectionView = UICollectionView(frame: .infinite,
                                                   collectionViewLayout: UICollectionViewLayout.init())
    let newShopCardCell = NewCardCell()
    
    let shopNameLabel = UILabel()
    let shopRateLabel = UILabel()
    let shopRateDownButton = UIButton()
    let shopRateUpButton = UIButton()
    let votesView = UIView()
    let votesLabel = UILabel()
    
    let addressView = UIView()
    let addressSubView = UIView()
    let addressImageView = UIImageView()
    let addressLabel = UILabel()
    
    let basketButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init?(frame: CGRect, shop: ShopModel?) {
        super.init(frame: frame)
        
        self.currentShop = shop
        self.isLargeScreen = UIView.isLargeScreen()
        self.setupHeaderView()
        self.setupMainView()
        self.backgroundColor = UIColor(red: 245/255,
                                       green: 245/255,
                                       blue: 245/255,
                                       alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ShopCardView {
    fileprivate func setupHeaderView() {

        headerView.addSubview(headerLabelStackView)
        headerView.addSubview(headerButtonsStackView)
        headerView.addSubview(headerBorder)
        
        self.addSubview(headerView)
        
        headerView.backgroundColor = UIColor(red: 255/255,
                                             green: 255/255,
                                             blue: 255/255,
                                             alpha: 1)
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
        
        headerLabel.text = "hurry"
        headerLabel.textColor = UIColor(red: 218/255,
                                        green: 165/255,
                                        blue: 32/255,
                                        alpha: 1)
        headerLabel.textAlignment = .left
        headerLabel.attributedText = NSAttributedString(
            string: NSLocalizedString("hurry", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: (isLargeScreen ? 26 : 24)),
            NSAttributedString.Key.underlineStyle: 1.0,
        ])
        
        
        // change lang button
        headerChangeLangButton.setTitle("en",
                                        for: .normal)
        headerChangeLangButton.titleLabel?.font = UIFont
                                                    .boldSystemFont(ofSize: 15)
        headerChangeLangButton.setTitleColor(UIColor.black,
                                             for: .normal)
        headerChangeLangButton.layer.borderWidth = 1
        headerChangeLangButton.layer.cornerRadius = 5
        headerChangeLangButton.contentHorizontalAlignment = .center
        
        // go to shop page button
        headerGoToShopButton.setImage(UIImage(named: "shop"),
                                      for: .normal)
        headerGoToShopButton.contentHorizontalAlignment = .center
        
        // header image view
        headerImageView.image = UIImage(named: "hurry2")
        
        // settings button
        headerSettingsButton.setImage(UIImage(named: "settings"),
                                      for: .normal)

        
        //MARK: SETUP HEADER VIEW CONSTRAINTS
        headerView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(self.frame.height / 10)
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
            make.left.equalToSuperview()
                .inset(isLargeScreen ? 20 : 15)
        }
        
        headerButtonsStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview()
                .inset(isLargeScreen ? 20 : 15)
            
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
    }
    
    fileprivate func setupMainView() {
        
        let width = frame.width
        
        self.addSubview(shopNameLabel)
        self.addSubview(shopRateLabel)
        self.addSubview(votesView)
        self.addSubview(shopRateUpButton)
        self.addSubview(shopRateDownButton)
        self.addSubview(addressView)
        self.addSubview(positionsCollectionView)
        self.addSubview(basketButton)
        
        votesView.addSubview(votesLabel)
        addressView.addSubview(addressImageView)
        addressView.addSubview(addressSubView)
        
        addressSubView.addSubview(addressLabel)
        
        guard let shop = currentShop
        else { return }
        
        //MARK: SETUP MAIN VIEWS
        shopNameLabel.text = shop.info.title
        shopNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        shopNameLabel.textAlignment = .center
        
        shopRateLabel.text = "RATE: \(shop.rate.description)"
        shopRateLabel.font = .systemFont(ofSize: 20)
        shopRateLabel.textAlignment = .center
        shopRateLabel.textColor = UIColor(red: 218/255,
                                          green: 165/255,
                                          blue: 32/255,
                                          alpha: 1)
        
        let attrStringForUpLabel = NSAttributedString(
            string: NSLocalizedString("+", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        
        let attrStringForDownLabel = NSAttributedString(
            string: NSLocalizedString("-", comment: ""),
            attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        
        shopRateUpButton.setAttributedTitle(attrStringForUpLabel,
                                            for: .normal)
        
        shopRateDownButton.setAttributedTitle(attrStringForDownLabel,
                                              for: .normal)
        
        votesView.backgroundColor = UIColor(red: 218/255,
                                            green: 165/255,
                                            blue: 32/255,
                                            alpha: 1)
        
        votesView.layer
            .cornerRadius = 22.5
        
        votesLabel.textAlignment = .center
        votesLabel.font = .boldSystemFont(ofSize: 18)
        votesLabel.textColor = .white
        
        addressView.backgroundColor = UIColor(red: 229/255,
                                              green: 192/255,
                                              blue: 105/255,
                                              alpha: 1)
        addressView.layer.cornerRadius = 20
        addressView.layer.borderWidth = 1
        addressView.layer
            .borderColor = UIColor.black.cgColor
        
        let addressImage = UIImage(named: "address")
        addressImageView.image = addressImage
        
        addressSubView.backgroundColor = .white
        addressSubView.layer
            .borderColor = UIColor.black.cgColor
        addressSubView.layer.borderWidth = 1
        addressSubView.layer.cornerRadius = 15
        
        addressLabel.text = "\(shop.info.addr.country) \(shop.info.addr.city) \n\(shop.info.addr.street) \(shop.info.addr.build)"
        addressLabel.textAlignment = .left
        addressLabel.font = .systemFont(
            ofSize: isLargeScreen ? 18 : 14)
        addressLabel.numberOfLines = 0
        
        positionsCollectionView.backgroundColor = UIColor(red: 245/255,
                                                          green: 245/255,
                                                          blue: 245/255,
                                                          alpha: 245/255)
        
        positionsCollectionView.register(NewCardCell.self,
                                         forCellWithReuseIdentifier: "NewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = isLargeScreen ? CGSize(width: 180,
                                                     height: 180)
                                            : CGSize(width: 155,
                                                     height: 155)
        flowLayout.scrollDirection = .vertical
        flowLayout.footerReferenceSize = CGSize(width: frame.width,
                                                height: isLargeScreen ? 80 : 65)
        positionsCollectionView.collectionViewLayout = flowLayout
        positionsCollectionView.showsVerticalScrollIndicator = false
        
        basketButton.setTitle("Basket", for: .normal)
        basketButton.backgroundColor = UIColor(red: 0/255,
                                               green: 161/255,
                                               blue: 164/255,
                                               alpha: 1)
        basketButton.layer.cornerRadius = isLargeScreen ? 25 : 15
        

        //MARK: SETUP CONSTRAINTS FOR MAIN VIEWS
        shopNameLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 1.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(headerBorder.snp.bottom).offset(15)
        }
        
        shopRateLabel.snp.makeConstraints { make in
            make.width.equalTo(width / 3)
            make.centerX.equalToSuperview()
            make.top.equalTo(shopNameLabel.snp.bottom).offset(10)
        }
        
        shopRateDownButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.trailing.equalTo(shopRateLabel.snp.leading).offset(-5)
            make.top.equalTo(shopRateLabel.snp.top)
        }
        
        shopRateUpButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(shopRateLabel.snp.trailing).offset(5)
            make.top.equalTo(shopRateLabel.snp.top)
        }
        
        votesView.snp.makeConstraints { make in
            make.height.width.equalTo(45)
            make.leading.equalToSuperview().inset(width / 40)
            make.top.equalTo(shopNameLabel.snp.top)
        }
        
        votesLabel.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        addressView.snp.makeConstraints { make in
            make.width.equalTo(frame.width / 1.5)
            make.height.equalTo(isLargeScreen ? (frame.height / 12)
                                : (frame.height / 10))
            make.centerX.equalToSuperview()
            make.top.equalTo(shopRateLabel.snp.bottom).offset(10)
        }
        
        addressSubView.snp.makeConstraints { make in
            make.width.equalTo((frame.width / 1.5) * 0.8)
            make.height.equalTo((frame.height / 12) * 0.8)
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
        
        addressImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(addressSubView.snp.leading).offset(-5)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.width.equalTo(((frame.width / 1.5) * 0.8) * 0.9)
            make.height.equalTo(((frame.height / 12) * 0.8) * 0.8)
            make.centerY.centerX.equalToSuperview()
        }
        
        positionsCollectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(isLargeScreen ? 10 : 20)
            make.trailing.equalToSuperview().offset(isLargeScreen ? -10 : -20)
            make.top.equalTo(addressView.snp.bottom).offset(20)
            
        }
        
        basketButton.snp.makeConstraints { make in
            make.width.equalTo(isLargeScreen ? 100 : 80)
            make.height.equalTo(isLargeScreen ? 50 : 35)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(isLargeScreen
                                                  ? -40 : -20)
        }
    }
}




extension ShopCardView {
    fileprivate func isLargeScreen(frame: CGRect) -> Bool {
        return frame.size.height > 670
            ? true : false
    }
}

