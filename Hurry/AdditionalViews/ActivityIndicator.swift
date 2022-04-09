//
//  AdditionalViews.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 31.03.2022.
//

import Foundation
import UIKit

class ActivityIndicator: UIView {
    let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = UIColor.red.cgColor
        spinningCircle.lineWidth = 5
        spinningCircle.strokeEnd = 0.75
        spinningCircle.lineCap = .round
        
        self.layer.addSublayer(spinningCircle)
    }
    
    
    func animate(with duration: Double) {
        var secondsToEnd = duration
        self.isHidden = false

        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in
                if secondsToEnd > 0 {
                    secondsToEnd -= 2
                    self.animate(with: secondsToEnd)
                } else {
                    self.isHidden = true
                }
            }
        }
    }
    
    func addActivityIndicator(view: UIView) {
        view.addSubview(self)
    }
    
    func removeSelf() {
        self.removeFromSuperview()
    }
    
    func animate(with duration: Double, complition: @escaping () -> Void) {
        var secondsToEnd = duration
        self.isHidden = false

        UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in
                if secondsToEnd > 0 {
                    secondsToEnd -= 2
                    self.animate(with: secondsToEnd) {
                        complition()
                    }
                } else {
                    complition()
                    self.isHidden = true
                }
            }
        }
    }
    
    func setActivityIndicatorForSaveButton(with frame: CGRect) {
        self.frame = CGRect(x: frame.midX - 10, y: frame.minY + 15, width: 20, height: 20)
    }

    func setActivityIndicatorForRateLabel(with frame: CGRect) {
        self.frame = CGRect(x: frame.midX - 10, y: frame.minY, width: 20, height: 20)
    }
}

