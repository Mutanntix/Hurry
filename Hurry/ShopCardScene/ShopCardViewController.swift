//
//  ShopCardViewController.swift
//  Hurry
//
//  Created by Мурад on 12.03.2022.
//

import UIKit


class ShopCardViewController: UIViewController {
    
    weak var networkDelegate: NetworkDelegate?
    
    var currentShop: ShopModel?
    var productAttributes: [ShopCardCellAttributes] = []
    var choosenProducts: [Product] = []
    
    fileprivate var mainView: ShopCardView {
        return self.view as! ShopCardView
    }
    
    override func loadView() {
        self.view = ShopCardView(frame: UIScreen.main.bounds,
                                 shop: currentShop)
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
        
        mainView.headerGoToShopButton.addTarget(self,
                                                action: #selector(goToShopVC),
                                                for: .touchUpInside)
        
        mainView.headerSettingsButton.addTarget(self,
                                                action: #selector(goToAdminVC),
                                                for: .touchUpInside)
        
        mainView.basketButton.addTarget(self, action: #selector(goToBasketVC),
                                        for: .touchUpInside)
        
        mainView.shopRateUpButton.addTarget(self,
                                            action: #selector(rateUpButtonPressed),
                                            for: .touchUpInside)
        
        mainView.shopRateDownButton.addTarget(self,
                                              action: #selector(rateDownButtonPressed),
                                              for: .touchUpInside)
        
        networkDelegate?.getVotes(
            complition: { [weak self] votes in
                guard let votes = votes else {
                    return
                }
                self?.mainView
                    .votesLabel.text = votes
        })
    }
}

extension ShopCardViewController: UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let shop = currentShop
        else { return 0 }
        return shop.menu.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCell",
                                                         for: indexPath) as? NewCardCell {
            cell.setupShopCardCell(with: productAttributes[indexPath.item],
                                   isLargeScreen: mainView.isLargeScreen)
            cell.setupConstraints(isLargeScreen: mainView.isLargeScreen)
            cell.addToBasketButton.addTarget(self,
                                             action: #selector(addToBasketAction),
                                             for: .touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: METHODS
extension ShopCardViewController {
    @objc private func rateUpButtonPressed() {
        guard let shop = currentShop else { return }
        self.disableRateButtons()
        
        let activityIndicator = ActivityIndicator()
        activityIndicator
            .addActivityIndicator(view: mainView)
        activityIndicator
            .setActivityIndicatorForRateLabel(
                with: mainView.shopRateLabel.frame)
        activityIndicator.animate(with: 4)
    
        networkDelegate?.rateUp(shop: shop,
                                complition: { [weak self] okResult in
            guard var currentShop = self?.currentShop
            else { return }

            if okResult {
                self?.networkDelegate?
                    .getVotes(complition: { result in
                        self?.mainView
                            .votesLabel.text = result ?? ""
                    })
                
                currentShop.rate += 1
                self?.currentShop = currentShop
                self?.mainView
                    .shopRateLabel.text = "RATE: \(currentShop.rate)"
                activityIndicator.removeFromSuperview()
                self?.enableRateButtons()
            }
        })
    }
    
    @objc private func rateDownButtonPressed() {
        guard let shop = currentShop else { return }
        self.disableRateButtons()
        
        let activityIndicator = ActivityIndicator()
        activityIndicator
            .addActivityIndicator(view: mainView)
        activityIndicator
            .setActivityIndicatorForRateLabel(
                with: mainView.shopRateLabel.frame)
        activityIndicator.animate(with: 4)

        networkDelegate?.rateDown(shop: shop,
                                complition: { [weak self] okResult in
            guard var currentShop = self?.currentShop
            else { return }

            if okResult {
                self?.networkDelegate?
                    .getVotes(complition: { result in
                self?.mainView
                            .votesLabel.text = result ?? ""
                    })
                
                currentShop.rate -= 1
                self?.currentShop = currentShop
                self?.mainView
                    .shopRateLabel.text = "RATE: \(currentShop.rate)"
                activityIndicator.removeFromSuperview()
                self?.enableRateButtons()
            }
        })
    }
    
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
    
    @objc fileprivate func goToBasketVC() {
        let basketVC = BusketViewController()
        self.mainView.basketButton.isEnabled = false
        self.mainView.basketButton.setTitle("wait...", for: .normal)
        self.mainView.basketButton.backgroundColor = .lightGray

        networkDelegate?.getCurrentBasket(complition: { [weak self] currentBasket in
            guard let self = self else { return }
            guard let currentBasket = currentBasket
            else {
                Alert.showAlert(vc: self,
                                message: "Something went wrong...",
                                title: "Unexpected error",
                                alertType: .serverErrorAlert,
                                complition: { [weak self] in
                    self?.mainView.basketButton.isEnabled = true
                    self?.mainView.basketButton.setTitle("basket", for: .normal)
                    self?.mainView.basketButton.backgroundColor = UIColor(red: 0/255,
                                                                          green: 161/255,
                                                                          blue: 164/255,
                                                                          alpha: 1)

                })
                return
            }

            basketVC.currentBasket = currentBasket
            basketVC.currentShop = self.currentShop
            basketVC.networkDelegate = self.networkDelegate
            basketVC.delegate = self
            self.present(UINavigationController(rootViewController: basketVC), animated: true, completion: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
                self?.mainView.basketButton.isEnabled = true
                self?.mainView.basketButton.setTitle("basket", for: .normal)
                self?.mainView.basketButton.backgroundColor = UIColor(red: 0/255, green: 161/255, blue: 164/255, alpha: 1)
            })
        })
    }
    
    @objc fileprivate func addToBasketAction(sender: UIButton) {
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
        
        guard let currentShop = currentShop else { return }
        let choosenProduct = currentShop.menu[indexPath.item]
        networkDelegate?.basketPut(shop: currentShop, indexPath: indexPath)
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
    
    private func disableRateButtons() {
        mainView.shopRateLabel.isHidden = true
        
        mainView.shopRateDownButton.isEnabled = false
        mainView.shopRateUpButton.isEnabled = false
    }
    
    private func enableRateButtons() {
        mainView.shopRateLabel.isHidden = false
        
        mainView.shopRateDownButton.isEnabled = true
        mainView.shopRateUpButton.isEnabled = true
    }
}

//MARK: -SuccessOrderView
extension ShopCardViewController: BusketViewControllerDelegate {
    func showSuccessOrderView() {
        let succOrderView = SuccessOrderView(frame: CGRect(x: view.frame.midX -
                                                           ((view.frame.width * 0.98) / 2),
                                                           y: view.frame.minY - 100,
                                                           width: view.frame.width * 0.98,
                                                           height: 70))
        view.addSubview(succOrderView)
        
        UIView.animate(withDuration: 0.1,
                       delay: 1,
                       options: .curveLinear) {
            UIView.moveToBottom(view: succOrderView, pointsToMove: 200)
        }
        
        UIView.animate(withDuration: 0.07,
                       delay: 4,
                       options: .curveLinear) {
            UIView.moveToTop(view: succOrderView, pointsToMove: 200)
        } completion: { _ in
            succOrderView.removeFromSuperview()
        }
    }
}

