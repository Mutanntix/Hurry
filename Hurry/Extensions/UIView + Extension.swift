//
//  UIView + Extension.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 07.04.2022.
//

import Foundation
import UIKit

extension UIView {
    static func moveToBottom(view: UIView,
                             pointsToMove: CGFloat) {
        view.center.y += pointsToMove
    }
    
    static func moveToTop(view: UIView,
                          pointsToMove: CGFloat) {
        view.center.y -= pointsToMove
    }

    static func isLargeScreen() -> Bool {
        let result = UIScreen
            .main.bounds.height > 670
        return result
    }
}
