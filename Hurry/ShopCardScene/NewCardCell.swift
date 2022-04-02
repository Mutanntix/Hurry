//
//  NewCardCell.swift
//  Hurry
//
//  Created by Мурад on 14.03.2022.
//

import UIKit
import SnapKit

struct ShopCardCellAttributes {
    let name: String
    let size: String
    let price: String
}

class NewCardCell: UICollectionViewCell {
    let backGroundView = UIView()
    let productNameBackgroundView = UIView()
    let productNameLabel = UILabel()
    let productSizeLabel = UILabel()
    let productPriceLabel = UILabel()
    let addToBasketButton = UIButton()
    
    override var reuseIdentifier: String? {
       return "NewCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupShopCardCell(with attr: ShopCardCellAttributes, isLargeScreen: Bool) {
        self.addSubview(backGroundView)
        backGroundView.addSubview(productNameBackgroundView)
        productNameBackgroundView.addSubview(productNameLabel)
        backGroundView.addSubview(productPriceLabel)
        backGroundView.addSubview(productSizeLabel)
        backGroundView.addSubview(addToBasketButton)
        
        self.backGroundView.backgroundColor = .clear
        self.backGroundView.layer.borderColor = UIColor.black.cgColor
        self.backGroundView.layer.borderWidth = 1
        self.backGroundView.layer.cornerRadius = 20
        
        self.productNameBackgroundView.backgroundColor = UIColor(red: 229/255, green: 192/255, blue: 105/255, alpha: 1)
        self.productNameBackgroundView.layer.cornerRadius = 20
        self.productNameBackgroundView.layer.cornerRadius = isLargeScreen ? 20 : 15
        
        self.productNameLabel.text = attr.name
        self.productNameLabel.textAlignment = .center
        self.productNameLabel.backgroundColor = .clear
        self.productNameLabel.font = .systemFont(ofSize: isLargeScreen ? 18 : 14)
        self.productNameLabel.numberOfLines = 0
        
        self.productSizeLabel.text = "Size: \(attr.size)"
        self.productSizeLabel.textAlignment = .center
        self.productSizeLabel.font = .systemFont(ofSize: isLargeScreen ? 15 : 14)
        self.productSizeLabel.numberOfLines = 0
        
        self.productPriceLabel.text = "Price: \(attr.price)"
        self.productPriceLabel.textAlignment = .center
        self.productPriceLabel.font = .systemFont(ofSize: isLargeScreen ? 15 : 14)
        self.productPriceLabel.numberOfLines = 0
        
        self.addToBasketButton.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        self.addToBasketButton.layer.cornerRadius = isLargeScreen ? 15 : 13
        self.addToBasketButton.setTitle("to basket", for: .normal)
    }
    
    func setupConstraints(isLargeScreen: Bool) {
        switch isLargeScreen {
        case true:
            self.setupConstraintsForLargeScreen()
        case false:
            self.setupConstraintsForSmallScreen()
        }
    }
    
    private func setupConstraintsForLargeScreen() {
        self.backGroundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(2)
            make.centerX.centerY.equalToSuperview()
        }
        
        self.productNameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(backGroundView.snp.top).offset(10)
            make.height.equalTo(45)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        self.productNameLabel.snp.makeConstraints { make in
            make.centerY.centerX.width.height.equalToSuperview()
        }
        
        self.productPriceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(productNameBackgroundView.snp.bottom).offset(10)
        }
        
        self.productSizeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(productPriceLabel.snp.bottom).offset(5)
        }
        
        self.addToBasketButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.top.equalTo(productSizeLabel.snp.bottom).offset(20)
        }
        
    }
    
    private func setupConstraintsForSmallScreen() {
        self.backGroundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(2)
            make.centerX.centerY.equalToSuperview()
        }
        
        self.productNameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(backGroundView.snp.top).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        self.productNameLabel.snp.makeConstraints { make in
            make.centerY.centerX.width.height.equalToSuperview()
        }
        
        self.productPriceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(15)
            make.top.equalTo(productNameBackgroundView.snp.bottom).offset(10)
        }
        
        self.productSizeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(15)
            make.top.equalTo(productPriceLabel.snp.bottom).offset(5)
        }
        
        self.addToBasketButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(110)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
}
