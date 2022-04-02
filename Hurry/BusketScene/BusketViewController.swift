//
//  BusketViewController.swift
//  Hurry
//
//  Created by Мурад on 13.03.2022.
//
// hola

import UIKit

class BusketViewController: UIViewController {
    var products: [Product] = []
    
    var mainView: BusketMainView {
        return self.view as! BusketMainView
    }
    
    override func loadView() {
        self.view = BusketMainView(frame: UIScreen.main.bounds, products: products)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstInitializate()
    }
    


}

extension BusketViewController {
    fileprivate func firstInitializate() {
        mainView.basketTableView.delegate = self
        mainView.basketTableView.dataSource = self
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barCancelButtonPressed))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        mainView.orderButton.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
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

//MARK: METHODS
extension BusketViewController {
    @objc fileprivate func barCancelButtonPressed() {
        self.dismiss(animated: true) {
            //complition
        }
    }
    
    @objc fileprivate func orderButtonPressed(sender: UIButton) {
        sender.pulsate()
        let pickUpTime = getTimeFromPicker()
        print(pickUpTime)
    }
    
    private func getTimeFromPicker() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let userTime = dateFormatter.string(from: mainView.pickUpTimeDatePicker.date)
        
        return userTime
    }
}
