//
//  MainView.swift
//  Hurry
//
//  Created by Мурад on 10.03.2022.
//

import UIKit
import SnapKit

class MainView: UIView {
    var shopTableView = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstInitialization()
        self.setupConstraints()
        
    }
    
    private func firstInitialization() {
        self.addSubview(shopTableView)
        
        self.shopTableView.register(UINib(nibName: "ShopCell", bundle: nil),
                                    forCellReuseIdentifier: "ShopCell")
    }
    
    private func setupConstraints() {
        shopTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
