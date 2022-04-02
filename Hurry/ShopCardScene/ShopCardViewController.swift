//
//  ShopCardViewController.swift
//  Hurry
//
//  Created by Мурад on 12.03.2022.
//

import UIKit


class ShopCardViewController: UIViewController {
    
    var currentShop: ShopModel?
    var productAttributes: [ShopCardCellAttributes] = []
    var choosenProducts: [Product] = []
    
    fileprivate var mainView: ShopCardView {
        return self.view as! ShopCardView
    }
    
    override func loadView() {
        self.view = ShopCardView(frame: UIScreen.main.bounds, shop: currentShop)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstInitialization()
    }
    


}

extension ShopCardViewController {
    fileprivate func firstInitialization() {
        mainView.positionsCollectionView.delegate = self
        mainView.positionsCollectionView.dataSource = self
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        guard let shop = currentShop else { return }
        createProductAttributes(products: shop.menu)
        
        mainView.headerGoToShopButton.addTarget(self, action: #selector(goToShopVC), for: .touchUpInside)
        mainView.headerSettingsButton.addTarget(self, action: #selector(goToAdminVC), for: .touchUpInside)
        mainView.basketButton.addTarget(self, action: #selector(goToBusketVC), for: .touchUpInside)
    }
}

extension ShopCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let shop = currentShop
        else { return 0 }
        return shop.menu.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCell", for: indexPath) as? NewCardCell {
            cell.setupShopCardCell(with: productAttributes[indexPath.item], isLargeScreen: mainView.isLargeScreen)
            cell.setupConstraints(isLargeScreen: mainView.isLargeScreen)
            cell.addToBasketButton.addTarget(self, action: #selector(addToBusketAction), for: .touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: METHODS
extension ShopCardViewController {
    @objc fileprivate func goToShopVC() {
        var shopVC: ShopViewController?
        guard let navigationController = self.navigationController else { return }
        
        for vc in navigationController.viewControllers {
            guard let attemptShopVC = vc as? ShopViewController else { continue }
            shopVC = attemptShopVC
        }
        guard let shopVC = shopVC else { return }

        self.navigationController?.popToViewController(shopVC, animated: false)
    }
    
    @objc fileprivate func goToAdminVC() {
        let adminVC = UserAdminViewController()
        self.navigationController?.pushViewController(adminVC, animated: false)
    }
    
    @objc fileprivate func goToBusketVC() {
        let busketVC = BusketViewController()
        busketVC.products = choosenProducts
        self.present(UINavigationController(rootViewController: busketVC), animated: true, completion: nil)
    }
    
    @objc fileprivate func addToBusketAction(sender: UIButton) {
        let basketButton = sender
        let buttonPosition = sender.convert(CGPoint.zero, to: self.mainView.positionsCollectionView)
        guard let indexPath = self.mainView.positionsCollectionView.indexPathForItem(at: buttonPosition) else { return }
        basketButton.pulsate()
        basketButton.backgroundColor = .lightGray
        basketButton.isEnabled = false
        basketButton.setTitle("wait...", for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            basketButton.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 32/255, alpha: 1)
            basketButton.isEnabled = true
            basketButton.setTitle("to basket", for: .normal)
        })
        
        guard let choosenProduct = currentShop?.menu[indexPath.item] else { return }
        choosenProducts.append(choosenProduct)
    }
    
    fileprivate func createProductAttributes(products: [Product]) {
        var productAttributes: [ShopCardCellAttributes] = []
        
        for product in products {
            productAttributes.append(ShopCardCellAttributes(name: product.title,
                                                            size: product.option,
                                                            price: product.price))
        }
        self.productAttributes = productAttributes
    }
}
