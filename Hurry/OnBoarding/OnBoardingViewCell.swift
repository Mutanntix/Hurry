//
//  OnBoardingViewCell.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 07.04.2022.
//

import UIKit
import SnapKit

class OnBoardingViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override var reuseIdentifier: String? {
       return "OnBoardingViewCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupOnBoardingCell(_ page: PageModel, isLargeScreen: Bool) {
        imageView.image = page.image
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        
        titleLabel.font = .systemFont(ofSize: 40)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        if isLargeScreen {
            setupConstraintsForLargeScreen()
        } else if !isLargeScreen {
            setupConstraintsForSmallScreen()
        }
    }
    
    func setupConstraintsForLargeScreen() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading
                .equalToSuperview().inset(16)
            make.top.equalTo(imageView.snp.bottom).offset(45)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.trailing.leading
                .equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            
        }
    }
    
    func setupConstraintsForSmallScreen() {
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.leading
                .equalToSuperview().inset(16)
            make.top.equalTo(imageView.snp.bottom).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.trailing.leading
                .equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            
        }
    }
}

