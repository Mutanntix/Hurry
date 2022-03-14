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
    
    let basketLabel = UILabel()
    let clearButton = UIButton()
    
    let basketTableView = UITableView()
    let emptyBasketBackView = UIView()
    let emptyBasketLabel = UILabel()
    let secretWordTF = UITextField()
    let totalLabel = UILabel()
    let pickUpTimeLabel = UILabel()
    let pickUpTimeDatePicker = UIDatePicker()
    let orderButton = UIButton()
    
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
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.addSubview(basketLabel)
        self.addSubview(clearButton)
        self.addSubview(basketTableView)
        basketTableView.addSubview(emptyBasketBackView)
        emptyBasketBackView.addSubview(emptyBasketLabel)
        self.addSubview(secretWordTF)
        self.addSubview(totalLabel)
        self.addSubview(pickUpTimeLabel)
        self.addSubview(pickUpTimeDatePicker)
        self.addSubview(orderButton)
        
        basketLabel.text = "Basket"
        basketLabel.textAlignment = .center
        basketLabel.font = .boldSystemFont(ofSize: isLargeScreen ? 35 : 30)
        
        clearButton.backgroundColor = .clear
        let attrForClearButton = NSAttributedString(string: NSLocalizedString("clear", comment: ""), attributes:[
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: (isLargeScreen ? 22 : 18)),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ])
        clearButton.setAttributedTitle(attrForClearButton, for: .normal)
        
        emptyBasketBackView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 245/255)
        emptyBasketBackView.layer.cornerRadius = isLargeScreen ? 20 : 15
        emptyBasketBackView.isHidden = !(products.isEmpty)
        
        emptyBasketLabel.text = "Your basket is emty..."
        emptyBasketLabel.textAlignment = .center
        emptyBasketLabel.font = .boldSystemFont(ofSize: 20)
        
        basketTableView.register(UINib(nibName: "BasketCell", bundle: nil), forCellReuseIdentifier: "BasketCell")
        basketTableView.layer.cornerRadius = 15
        basketTableView.layer.borderWidth = 2
        
        secretWordTF.placeholder = "Enter the secret word"
        secretWordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: secretWordTF.frame.height))
        secretWordTF.leftViewMode = .always
        secretWordTF.layer.borderColor = UIColor.black.cgColor
        secretWordTF.autocapitalizationType = .none
        secretWordTF.layer.borderWidth = 1.5
        secretWordTF.layer.cornerRadius = 10
        secretWordTF.keyboardType = UIKeyboardType.default
        secretWordTF.returnKeyType = UIReturnKeyType.done
        secretWordTF.autocorrectionType = UITextAutocorrectionType.no
        secretWordTF.font = UIFont.systemFont(ofSize: 15)
        secretWordTF.clearButtonMode = UITextField.ViewMode.whileEditing;
        secretWordTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        totalLabel.text = "Total: \(getTotal(from: products))"
        totalLabel.font = .systemFont(ofSize: isLargeScreen ? 30 : 25)
        totalLabel.textAlignment = .center
        
        pickUpTimeLabel.text = "Pick up at:"
        pickUpTimeLabel.font = .systemFont(ofSize: isLargeScreen ? 20 : 16)
        pickUpTimeLabel.textAlignment = .left
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        pickUpTimeDatePicker.datePickerMode = .time
        
        orderButton.setTitle("order", for: .normal)
        orderButton.backgroundColor = UIColor(red: 0/255, green: 161/255, blue: 164/255, alpha: 1)
        orderButton.layer.cornerRadius = isLargeScreen ? 23 : 18
        
    }
    
    fileprivate func setupConstraints(frame: CGRect) {
        basketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(basketLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(isLargeScreen ? 70 : 50)
            make.height.equalTo(isLargeScreen ? 25 : 20)
        }
        
        emptyBasketBackView.snp.makeConstraints { make in
            make.width.equalTo(frame.width / 1.5)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(isLargeScreen ? 60 : 45)
        }
        
        emptyBasketLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
        
        basketTableView.snp.makeConstraints { make in
            make.top.equalTo(clearButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(isLargeScreen ? 350 : 250)
        }
        
        secretWordTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(frame.width / 1.5)
            make.top.equalTo(basketTableView.snp.bottom).offset(25)
            make.height.equalTo(isLargeScreen ? 45 : 40)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(secretWordTF.snp.bottom).offset(isLargeScreen ? 30 : 15)
        }
        
        pickUpTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(isLargeScreen ? 15 : 10)
            make.leading.equalTo((frame.width / 2) - (frame.width * 0.24))
            make.height.equalTo(40)
        }
        
        pickUpTimeDatePicker.snp.makeConstraints { make in
            make.leading.equalTo(pickUpTimeLabel.snp.trailing).offset(20)
            make.top.equalTo(pickUpTimeLabel.snp.top)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(pickUpTimeLabel.snp.bottom).offset(isLargeScreen ? 25 : 35)
            make.height.equalTo(isLargeScreen ? 50 : 35)
            make.width.equalTo(frame.width / 3)
            make.centerX.equalToSuperview()
        }
    }
}


extension BusketMainView {
    fileprivate func isLargeScreen(frame: CGRect) -> Bool {
        return frame.size.height > 670 ? true : false
    }
    
    fileprivate func getTotal(from products: [Product]) -> Int {
        var total = 0
        for product in products {
            total += Int(product.price) ?? 0
        }
        return total
    }
}
