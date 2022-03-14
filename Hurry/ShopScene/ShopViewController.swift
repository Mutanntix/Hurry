//
//  ShopViewController.swift
//  Hurry
//
//  Created by Мурад on 08.03.2022.
//

import UIKit
import SnapKit
import Network

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var isUserOnline = NetworkManager.shared.isConnected
    private var shopOfferAttributes: [ShopCellAttributes] = []
    
    let shopSearchController = UISearchController(searchResultsController: nil)
    
    fileprivate var products: [Product] = {
        return [
        Product(name: "coffee", size: "250", price: "150"),
        Product(name: "coffee", size: "350", price: "250"),
        Product(name: "coffee another", size: "250", price: "150"),
        Product(name: "coffee another", size: "450", price: "300"),
        Product(name: "coffee", size: "250", price: "150"),
        Product(name: "coffee", size: "350", price: "250"),
        Product(name: "coffee another", size: "250", price: "150"),
        Product(name: "coffee another", size: "450", price: "300"),
        Product(name: "coffee", size: "250", price: "150"),
        Product(name: "coffee", size: "350", price: "250"),
        Product(name: "coffee another", size: "250", price: "150"),
        Product(name: "coffee another", size: "450", price: "300")
        ]
    }()
    
    fileprivate lazy var shopList: [ShopModel] = {
        return [
            ShopModel(name: "StarBucks", rating: "5", country: "USA", city: "New-York", address: "Kirova 16", products: products),
            ShopModel(name: "DonatCoffee", rating: "7", country: "USA", city: "New-York", address: "Kirova 65", products: products),
            ShopModel(name: "OnePrice", rating: "5", country: "USA", city: "New-York", address: "Cosmonavtov 76", products: products),
            ShopModel(name: "SugarShop", rating: "14", country: "USA", city: "New-York", address: "Stankevicha 23", products: products),
            ShopModel(name: "OneBucks", rating: "5", country: "USA", city: "New-York", address: "Stepana Razina 16", products: products),
            ShopModel(name: "TruePriceCoffee", rating: "7", country: "USA", city: "New-York", address: "Kirova 16", products: products),
            ShopModel(name: "Wild Coffee", rating: "5", country: "USA", city: "New-York", address: "Kirova 65", products: products),
            ShopModel(name: "Wake me coffee", rating: "14", country: "USA", city: "New-York", address: "Perhorovicha 16", products: products)
        ]
    }()
    
    fileprivate var filteredShopList: [ShopModel] = []

    private var searchBarIsEmty: Bool {
        guard let text = shopSearchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return shopSearchController.isActive && !searchBarIsEmty
    }
    
    override func loadView() {
        self.view = ShopMainView(frame: UIScreen.main.bounds)
    }
    
    fileprivate var shopContentView: ShopMainView {
        return self.view as! ShopMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstInitializate()
    }
    

    private func firstInitializate() {
        getAttributesForCells()
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        
        self.shopContentView.shopTableView.delegate = self
        self.shopContentView.shopTableView.dataSource = self
        
        self.setupSearchBar()
        
        self.shopContentView.headerSettingsButton.addTarget(self, action: #selector(goToUserAdminVC), for: .touchUpInside)
        
    }
    
    private func setupSearchBar() {
        shopSearchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        shopSearchController.obscuresBackgroundDuringPresentation = false
        shopSearchController.searchBar.sizeToFit()
        shopSearchController.searchBar.placeholder = "search coffee shop"
        shopSearchController.hidesNavigationBarDuringPresentation = false
        shopSearchController.definesPresentationContext = false
        
        shopContentView.shopTableView.tableHeaderView = shopSearchController.searchBar
        shopContentView.shopTableView.tableFooterView = nil
    }

    private func getAttributesForCells() {
        var currentShopList: [ShopModel] = []
        if isFiltering {
            currentShopList = filteredShopList 
        } else {
            currentShopList = shopList
        }
        
        let testShopOfferModel = ShopsOfferModel(shops: currentShopList)
        createShopModelAttributes(model: testShopOfferModel)
    }

    
    private func createShopModelAttributes(model: ShopsOfferModel) {
        var shopModelAttributes: [ShopCellAttributes] = []
        
        for shop in model.shops {
            shopModelAttributes.append(ShopCellAttributes(name: shop.name,
                                                          rating: shop.rating,
                                                          country: shop.country,
                                                          city: shop.city))
        }
        
        self.shopOfferAttributes = shopModelAttributes
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredShopList.count
        }
        return shopList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell") as? ShopCell
        else { return UITableViewCell() }
        
        cell.setupShopCell(with: self.shopOfferAttributes[indexPath.row])
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row number \(indexPath.row) in section: \(indexPath.section)")

        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ShopCell else { return }

        
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
 
            selectedCell.borderView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            selectedCell.borderView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            if self.isFiltering {
                self.goToShopCardVC(shop: self.filteredShopList[indexPath.row])
            }
            else {
                self.goToShopCardVC(shop: self.shopList[indexPath.row])
            }
        }
    }
}

extension ShopViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    
    fileprivate func filterContentForSearchText(_ searchText: String) {
        filteredShopList = shopList.filter( { (shop: ShopModel) -> Bool in
            shop.name.lowercased().contains(searchText.lowercased())
        })
        getAttributesForCells()
        shopContentView.shopTableView.reloadData()
    }
}

//MARK: METHODS
extension ShopViewController {
    @objc fileprivate func goToUserAdminVC() {
        let userAdminVC = UserAdminViewController()
        self.navigationController?.pushViewController(userAdminVC, animated: false)
    }
    
    fileprivate func goToShopCardVC(shop: ShopModel) {
        let shopCardVC = ShopCardViewController()
        shopCardVC.currentShop = shop
        self.navigationController?.pushViewController(shopCardVC, animated: false)
    }
}

extension ShopViewController {
//    fileprivate func getCoffeeShops() -> [ShopModel] {
//        return [
//            ShopModel(name: "StarBucks", rating: "5", country: "USA", city: "New-York"),
//            ShopModel(name: "DonatCoffee", rating: "7", country: "USA", city: "New-York"),
//            ShopModel(name: "OnePrice", rating: "5", country: "USA", city: "New-York"),
//            ShopModel(name: "SugarShop", rating: "14", country: "USA", city: "New-York"),
//            ShopModel(name: "StarBucks", rating: "5", country: "USA", city: "New-York"),
//            ShopModel(name: "DonatCoffee", rating: "7", country: "USA", city: "New-York"),
//            ShopModel(name: "OnePrice", rating: "5", country: "USA", city: "New-York"),
//            ShopModel(name: "SugarShop", rating: "14", country: "USA", city: "New-York")
//        ]
//    }
}
