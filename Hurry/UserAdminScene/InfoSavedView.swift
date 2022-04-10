//
//  InfoSavedView.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 10.04.2022.
//

import Foundation
import UIKit
import SnapKit

class InfoSavedView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "hurryInfo")
        imageView.image = image
        
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Your profile info has been saved.
        Thank you!
        """
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30)
        
        return label
    }()

    let doneButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Done",
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
        let isLargeScreen = UIView.isLargeScreen()
        initialization(isLargeScreen: isLargeScreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization(isLargeScreen: Bool) {
        self.backgroundColor = UIColor(red: 253/255,
                                       green: 248/255,
                                       blue: 229/255,
                                       alpha: 1)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor
            .gray.cgColor
        self.addSubview(imageView)
        self.addSubview(infoLabel)
        self.addSubview(doneButton)
        
        if !isLargeScreen {
            self.infoLabel.font
                = .systemFont(ofSize: 23)
        }
        setupConstraints()
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
            make.leading
                .trailing.equalToSuperview()
                    .inset(16)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(self
                .frame.width / 1.2)
        }
    }
}

