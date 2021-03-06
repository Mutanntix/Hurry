//
//  ConnectTgView.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 09.04.2022.
//

import Foundation
import UIKit
import SnapKit

class ConnectTgView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "telegram")
        imageView.image = image
        
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Your code for tg has been copied.
        Please, press "go to bot" button
        and you will be directed to
        hurry's tg bot. Send this code
        to the bot.
        """
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25)
        
        return label
    }()

    let goToBotButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("go to the bot",
                        for: .normal)
        button.backgroundColor = UIColor(red: 34/255,
                                         green: 160/255,
                                         blue: 237/255,
                                         alpha: 1)
        button.layer.cornerRadius = 10
        
        return button
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
        self.backgroundColor = UIColor(red: 253/255,
                                       green: 248/255,
                                       blue: 229/255,
                                       alpha: 1)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.addSubview(imageView)
        self.addSubview(infoLabel)
        self.addSubview(goToBotButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(
                imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        goToBotButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(self
                .frame.width / 1.2)
        }
    }
}
