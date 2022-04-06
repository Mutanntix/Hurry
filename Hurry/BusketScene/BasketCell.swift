//
//  BasketCell.swift
//  Hurry
//
//  Created by Мурад on 13.03.2022.
//

import UIKit

class BasketCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    
    func setupBasketCell(with product: Product) {
        self.productName.text = product.title
        self.productSize.text = "\(product.option)"
    }
}
