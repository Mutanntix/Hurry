//
//  ShopCardCell.swift
//  Hurry
//
//  Created by Мурад on 12.03.2022.
//

import UIKit

struct ShopCardCellAttributes {
    let name: String
    let size: String
    let price: String
}

class ShopCardCell: UICollectionViewCell {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var productNameBackgroundView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var produceSizeLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    override var reuseIdentifier: String? {
        return "ShopCardCell"
    }
    
    func setupShopCardCell(with attr: ShopCardCellAttributes) {
        self.backGroundView.backgroundColor = .clear
        self.backGroundView.layer.borderColor = UIColor.black.cgColor
        self.backGroundView.layer.borderWidth = 1
        self.backGroundView.layer.cornerRadius = 20
        
        self.productNameBackgroundView.backgroundColor = UIColor(red: 229/255, green: 192/255, blue: 105/255, alpha: 1)
        self.productNameBackgroundView.layer.cornerRadius = 20
        
        self.productNameLabel.text = attr.name
        self.productNameLabel.textAlignment = .center
        self.productNameLabel.backgroundColor = .clear
        self.productNameLabel.font = .systemFont(ofSize: 18)
        self.productNameLabel.numberOfLines = 0
        
        self.produceSizeLabel.text = "Size: \(attr.size) ml"
        self.produceSizeLabel.textAlignment = .center
        self.produceSizeLabel.font = .systemFont(ofSize: 15)
        self.produceSizeLabel.numberOfLines = 0
        
        self.productPriceLabel.text = "Price: \(attr.price) rub"
        self.productPriceLabel.textAlignment = .center
        self.productPriceLabel.font = .systemFont(ofSize: 15)
        self.productPriceLabel.numberOfLines = 0
        
        self.addToBasketButton.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
        self.addToBasketButton.layer.cornerRadius = 15
        
    }
}
