//
//  SuccessOrderView.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 07.04.2022.
//

import UIKit
import SnapKit

class SuccessOrderView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "success")
        imageView.image = image
        
        return imageView
    }()

    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "The order created. Have a good day!"
        textLabel.font = .systemFont(ofSize: 18)
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.backgroundColor = UIColor(red: 245/255,
                                       green: 245/255,
                                       blue: 245/255,
                                       alpha: 1)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.addSubview(imageView)
        self.addSubview(textLabel)
        
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(45)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).inset(-10)
            make.height.equalToSuperview()
            make.width.equalTo(self.frame.width / 1.5)
        }
    }
}
