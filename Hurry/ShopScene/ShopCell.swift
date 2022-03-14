//
//  ShopCell.swift
//  Hurry
//
//  Created by Мурад on 10.03.2022.
//

import UIKit

struct ShopCellAttributes {
    let name: String
    var rating: String
    let country: String
    let city: String
}

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var coffeeShopLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    override var reuseIdentifier: String? {
        return "ShopCell"
    }
    
    func setupShopCell(with attr: ShopCellAttributes) {
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.coffeeShopLabel.text = attr.name
        self.ratingLabel.text = "rating: \(attr.rating)"
        self.countryLabel.text = "\(attr.country) \(attr.city)"
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.cornerRadius = 15
    }
    
}

