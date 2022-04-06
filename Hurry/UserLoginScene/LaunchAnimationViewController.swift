//
//  LaunchAnimationViewController.swift
//  Hurry
//
//  Created by Мурад on 21.02.2022.
//

import UIKit
import SnapKit

class LaunchAnimationViewController: UIViewController {
    
    let hurryImage = UIImage(named: "hurryMain")
    var networkDelegate = NetworkDelegate()

    override func viewDidLoad()  {
        super.viewDidLoad()
        initializate()
    }
    
    func initializate() {
        
        view.backgroundColor = UIColor(red: 245/255,
                                       green: 245/255,
                                       blue: 245/255,
                                       alpha: 1)
        
        let imageView = UIImageView()
        let awaitLabel = UILabel()
        let activityIndicator = UIActivityIndicatorView()
        
        imageView.image = hurryImage
        
        awaitLabel.text = "by mutanntix"
        awaitLabel.font = UIFont.boldSystemFont(ofSize: 20)
        awaitLabel.alpha = 1
        awaitLabel.textAlignment = .center
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        view.addSubview(imageView)
        view.addSubview(awaitLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        awaitLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).inset(-25)
        }
        
        
        UIView.animate(withDuration: 2.5,
                       delay: 0,
                       options: .allowAnimatedContent) {
            imageView.alpha = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                self.networkDelegate.checkUid { isUidAvailable in
                    if isUidAvailable {
                        self.performSegue(to: ShopViewController())
                    } else {
                        self.performSegue(to: UserLoginViewController())
                    }
                }
            }
        }
    }
    
    private func performSegue(to vc: UIViewController) {
        if let shopVC = vc as? ShopViewController {
            shopVC.networkDelegate = self.networkDelegate
            self.navigationController?.pushViewController(shopVC,
                                                          animated: false)
        } else if let userLoginVc = vc as? UserLoginViewController {
            userLoginVc.networkDelegate = self.networkDelegate
            self.navigationController?.pushViewController(userLoginVc,
                                                          animated: false)
        }
    }
}

