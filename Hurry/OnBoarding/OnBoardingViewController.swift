//
//  OnBoardingViewController.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 06.04.2022.
//

import Foundation
import UIKit
import SwiftyOnboard

class OnBoardingViewController: UIViewController {
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        initializate()
    }
    
    private func initializate() {
        let swiftyOnBoard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnBoard)
        swiftyOnBoard.dataSource = self
    }
}

extension OnBoardingViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        return page
    }
    
    
}
