//
//  ShopViewController.swift
//  Hurry
//
//  Created by Мурад on 08.03.2022.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate var shopContentView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstInitializate()
    }
    
    private func firstInitializate() {
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        
        ShopVCSetupManager.shared.setupShopVCHeader(viewController: self)
        
        self.shopContentView.shopTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    @objc func goToUserAdminVC() {
        let userAdminVC = UserAdminViewController()
        self.navigationController?.pushViewController(userAdminVC, animated: false)
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }

}
