//
//  UserAdminViewControllerProtocol.swift
//  Hurry
//
//  Created by Мурад on 11.03.2022.
//

import Foundation
import UIKit

protocol UserAdminViewControllerProtocol {
    func saveChanges(view: UIView, button: UIButton)
    func connectTelegram(button: UIButton)
    func openChangePasswordVC(button: UIButton)
    func logout(button: UIButton)
}
