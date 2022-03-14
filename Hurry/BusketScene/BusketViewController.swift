//
//  BusketViewController.swift
//  Hurry
//
//  Created by Мурад on 13.03.2022.
//

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
        
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barCancelButtonPressed))
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

//MARK: METHODS
extension BusketViewController {
    @objc fileprivate func barCancelButtonPressed() {
        self.dismiss(animated: true) {
            //complition
        }
    }
}
