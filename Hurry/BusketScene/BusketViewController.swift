//
//  BusketViewController.swift
//  Hurry
//
//  Created by Мурад on 13.03.2022.
//
// hola

import UIKit

protocol BusketViewControllerDelegate: AnyObject {
    func showSuccessOrderView()
}

class BusketViewController: UIViewController {
    
    weak var networkDelegate: NetworkDelegate?
    var products: [Product] = []
    var currentShop: ShopModel?
    var currentBasket: [[String: Product]] = [[:]]
    
    var mainView: BusketMainView {
        return self.view as! BusketMainView
    }
    
    override func loadView() {
        self.view = BusketMainView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstInitializate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainView.secretWordTF.resignFirstResponder()
    }
}

extension BusketViewController {
    fileprivate func firstInitializate() {
        mainView.basketTableView.delegate = self
        mainView.basketTableView.dataSource = self
        mainView.secretWordTF.delegate = self
        
        setupViewWithBasket()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barCancelButtonPressed))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        mainView.orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
        mainView.clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
    }
}

//MARK: TABLE VIEW DATA SOURSE
extension BusketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell") as? BasketCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setupBasketCell(with: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//MARK: -UITextFieldDelegate
extension BusketViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: -METHODS
extension BusketViewController {
    @objc fileprivate func barCancelButtonPressed() {
        self.dismiss(animated: true) {
            //complition
        }
    }
    
    @objc fileprivate func orderButtonPressed(sender: UIButton) {
        sender.pulsate()
        let pickUpTime = getTimeFromPicker()
        guard let shop = currentShop else { return }
        guard let secretWord = mainView.secretWordTF.text else { return }
        let total = getTotal(from: products)
        networkDelegate?.sendOrder(basket: currentBasket,
                                   shop: shop,
                                   secretWord: secretWord,
                                   pickUpTime: pickUpTime,
                                   total: total,
                                   complition: { [weak self] success in
            if success {
                self?.currentBasket = [[:]]
                self?.setupViewWithBasket()
            } else {
                guard let self = self else { return }
                Alert.showAlert(vc: self,
                                message: "The server is not responding",
                                title: "Unexpected error",
                                alertType: .serverErrorAlert,
                                complition: {})
            }
        })
    }
    
    @objc fileprivate func clearButtonPressed(sender: UIButton) {
        sender.pulsate()
        self.networkDelegate?.clearBasket(complition: { [weak self] isCleared in
            guard let self = self else { return }
            
            if isCleared {
                self.currentBasket = [[:]]
                self.setupViewWithBasket()
            }
        })
    }
    
    private func getTimeFromPicker() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let userTime = dateFormatter.string(from: mainView.pickUpTimeDatePicker.date)
        
        return userTime
    }
    
    private func setupViewWithBasket() {
        getCurrentBasketProducts(from: currentBasket)
        let totalPrice = getTotal(from: self.products)
        setEmptyBasketState(from: totalPrice)
        setupTotalLabel(from: totalPrice)
        self.mainView.basketTableView.reloadData()
    }
    
    private func getCurrentBasketProducts(from dicArray: [[String: Product]]) {
        var products: [Product] = []
        for dic in dicArray {
            products.append(contentsOf: dic.values)
        }
        self.products = products
    }
    
    private func getTotal(from products: [Product]) -> Int {
        var total = 0
        for product in products {
            let productPrice = product.price.filter("0123456789".contains)
            total += Int(productPrice) ?? 0
        }
        return total
    }
    
    private func setEmptyBasketState(from total: Int) {
        self.mainView.emptyBasketBackView.isHidden = total != 0
    }
    
    private func setupTotalLabel(from total: Int) {
        self.mainView.totalLabel.text = "Your total is: \(total)"
    }
}

//MARK: -Keyboard Methods
extension BusketViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue else { return }
        
        let keyboardFrame = keyboardSize.cgRectValue
        self.navigationItem.leftBarButtonItem = nil
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardFrame.height * 0.7)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                    target: self,
                                                    action: #selector(self.barCancelButtonPressed))
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
        }
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
