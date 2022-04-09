//
//  ConnectTgView.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 09.04.2022.
//

import Foundation
import UIKit
import SnapKit

//class ScrollForTGView: UIScrollView {
//    let connectView = ConnectTgView(
//        frame: UIScreen.main.bounds)
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.frame = CGRect(x: frame.midX - 150,
//                            y: frame.minY + 100,
//                            width: 300,
//                            height: 600)
//        initialization()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func initialization() {
//        self.addSubview(connectView)
//        self.contentSize = CGSize(width: 300,
//                                  height: 1000)
//        self.backgroundColor = .clear
//    }
//
//    private func setupConstraints() {
//        connectView.snp.makeConstraints { make in
//            make.leading.trailing
//                .equalToSuperview().inset(25)
//            make.width.equalTo(250)
//            make.height.equalTo(350)
//        }
//    }
//}

class ConnectTgView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "success")
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
        label.font = .systemFont(ofSize: 18)
        
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
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(45)
            make.centerX.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(
                imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        goToBotButton.snp.makeConstraints { make in
            make.top.equalTo(
                infoLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(self
                .frame.width / 1.2)
        }
    }
}
