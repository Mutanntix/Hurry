//
//  LaunchAnimationViewController.swift
//  Hurry
//
//  Created by Мурад on 21.02.2022.
//

import UIKit
import SnapKit

class LaunchAnimationViewController: UIViewController {
    
    let hurryImage = UIImage(named: "HurryImage")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.performSegue()
        }

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
    }
    
    private func performSegue() {
        let userLoginVc = UserLoginViewController()
        self.navigationController?.pushViewController(userLoginVc, animated: false)
       // self.present(userLoginVc, animated: true, completion: nil)
    }



}
