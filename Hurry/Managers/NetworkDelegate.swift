//
//  NetworkDelegate.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 02.04.2022.
//

import Foundation

class NetworkDelegate: NetworkProtocol {
    func checkConnection() -> Bool {
        return NetworkManager.shared.isConnected
    }
    
    func loginUser(login: String,
                   password: String,
                   complition: @escaping (Bool) -> Void) {
        NetworkManager.shared.loginUser(login: login, password: password, completion: complition)
    }
    
    func checkUid(complition: @escaping (Bool) -> Void) {
        NetworkManager.shared.checkUID(completion: complition)
    }
    
    func getShops(complition: @escaping ([ShopModel]) -> Void) {
        NetworkManager.shared.getShops(complition: complition)
    }
    
    func forgotUserPassword(login: String) {
        NetworkManager.shared.forgotUserPassword(login: login)
    }
    
    func changePassword(newPassword: String) {
        NetworkManager.shared.changeUserPassword(newPass: newPassword)
    }
    
    func deleteUser() {
        NetworkManager.shared.deleteUser()
    }
    
    func basketPut(shop: ShopModel,
                   indexPath: IndexPath) {
        NetworkManager.shared.basketPut(shop: shop, indexPath: indexPath)
    }
    
    func getCurrentBasket(complition: @escaping ([[String: Product]]?) -> Void) {
        NetworkManager.shared.getCurrentBasket(complition: complition)
    }
    
    func clearBasket(complition: @escaping (Bool) -> Void) {
        NetworkManager.shared.clearBasket(complition: complition)
    }
    
    func regUser(login: String, password: String,
                 completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.regUser(login: login,
                                      password: password,
                                      completion: completion)
    }
    
    func sendOrder(basket: [[String: Product]],
                   shop: ShopModel,
                   secretWord: String,
                   pickUpTime: String,
                   total: Int,
                   complition: @escaping (Bool) -> Void) {
        NetworkManager.shared.sendOrder(basket: basket,
                                        shop: shop,
                                        secretWord: secretWord,
                                        pickUpTime: pickUpTime,
                                        total: total,
                                        complition: complition)
    }
}
