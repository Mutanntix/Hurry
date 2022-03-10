//
//  ShopCell.swift
//  Hurry
//
//  Created by Мурад on 10.03.2022.
//

import UIKit

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var coffeeShopLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.borderWidth = 2
        borderView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
