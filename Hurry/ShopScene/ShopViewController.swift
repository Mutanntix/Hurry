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

    weak var networkDelegate: NetworkDelegate?
    private var shopOfferAttributes: [ShopCellAttributes] = []
    
    let shopSearchController = UISearchController(searchResultsController: nil)
    
    
    fileprivate lazy var shopList: [ShopModel] = {
        return [

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
        receiveShops()
        
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
        createShopModelAttributes(models: currentShopList)
    }

    
    private func createShopModelAttributes(models: [ShopModel]) {
        var shopModelAttributes: [ShopCellAttributes] = []
        
        for shop in models {
            shopModelAttributes.append(ShopCellAttributes(name: shop.info.title,
                                                          rating: shop.rate.description,
                                                          country: shop.info.addr.country,
                                                          city: shop.info.addr.city))
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
    
    private func receiveShops() {
        networkDelegate?.getShops { shops in
            self.shopList = shops
            self.getAttributesForCells()
            self.shopContentView.shopTableView.reloadData()
        }
    }
}

extension ShopViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    
    fileprivate func filterContentForSearchText(_ searchText: String) {
        filteredShopList = shopList.filter( { (shop: ShopModel) -> Bool in
            shop.info.title.lowercased().contains(searchText.lowercased())
        })
        getAttributesForCells()
        shopContentView.shopTableView.reloadData()
    }
}

//MARK: METHODS
extension ShopViewController {
    @objc fileprivate func goToUserAdminVC() {
        let userAdminVC = UserAdminViewController()
        userAdminVC.networkDelegate = self.networkDelegate
        self.navigationController?.pushViewController(userAdminVC, animated: false)
    }
    
    fileprivate func goToShopCardVC(shop: ShopModel) {
        let shopCardVC = ShopCardViewController()
        shopCardVC.currentShop = shop
        shopCardVC.networkDelegate = self.networkDelegate
        
        self.navigationController?.pushViewController(shopCardVC, animated: false)
    }
}

