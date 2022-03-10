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

    override func viewDidLoad()  {
        super.viewDidLoad()
        initializate()

    }
    
    func initializate() {
        
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let imageView = UIImageView()
        imageView.image = hurryImage
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .allowAnimatedContent) {
            imageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            imageView.alpha = 0.1
            
            NetworkManager.shared.checkUID { isUidAvailable in
                if isUidAvailable {
                    self.performSegue(to: ShopViewController())
                } else {
                    self.performSegue(to: UserLoginViewController())
                }
            }

        }

    }
    
    private func performSegue(to vc: UIViewController) {
        if let shopVC = vc as? ShopViewController {
            self.navigationController?.pushViewController(shopVC, animated: false)
        } else if let userLoginVc = vc as? UserLoginViewController {
            self.navigationController?.pushViewController(userLoginVc, animated: false)
        }

       
    }
}

