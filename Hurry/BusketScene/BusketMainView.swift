//
//  BusketMainView.swift
//  Hurry
//
//  Created by Мурад on 13.03.2022.
//

import UIKit

class BusketMainView: UIView {
    lazy var isLargeScreen = self.isLargeScreen(frame: frame)
    var products: [Product] = []
    
    let busketLabel = UILabel()
    let clearButton = UIButton()
    let busketTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init?(frame: CGRect, products: [Product]) {
        super.init(frame: frame)
        self.products = products
        setupViews()
        setupConstraints(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BusketMainView {
    fileprivate func setupViews() {
        self.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        
        self.addSubview(busketLabel)
        self.addSubview(clearButton)
        
        busketLabel.text = "Busket"
        busketLabel.textAlignment = .center
        busketLabel.font = .boldSystemFont(ofSize: isLargeScreen ? 35 : 30)
        
        clearButton.backgroundColor = .clear
        let attrForClearButton = NSAttributedString(string: NSLocalizedString("clear", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: (isLargeScreen ? 22 : 18)),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        clearButton.setAttributedTitle(attrForClearButton, for: .normal)
        
    }
    
    fileprivate func setupConstraints(frame: CGRect) {
        busketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(busketLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(isLargeScreen ? 70 : 50)
            make.height.equalTo(isLargeScreen ? 25 : 20)
        }
    }
}


extension BusketMainView {
    fileprivate func isLargeScreen(frame: CGRect) -> Bool {
        return frame.size.height > 670 ? true : false
    }
}
