//
//  NetworkProtocol.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 02.04.2022.
//

import Foundation

protocol NetworkProtocol: AnyObject {
    func checkConnection() -> Bool
    
    func loginUser(login: String, password: String, complition: @escaping (Bool) -> Void)
    
    func checkUid(complition: @escaping (Bool) -> Void)
    
    func getShops(complition: @escaping ([ShopModel]) -> Void)
    
    func forgotUserPassword(login: String)
    
    func changePassword(newPassword: String)
    
    func deleteUser()
    
    func basketPut(shop: ShopModel,
                   indexPath: IndexPath)
    
    func getCurrentBasket(complition: @escaping ([[String: Product]]?) -> Void)
    
    func clearBasket(complition: @escaping (Bool) -> Void)
    
    func regUser(login: String,
                 password: String,
                 completion: @escaping (Bool) -> Void)
    
    func sendOrder(basket: [[String: Product]],
                   shop: ShopModel,
                   secretWord: String,
                   pickUpTime: String,
                   total: Int,
                   complition: @escaping (Bool) -> Void)
    
    func getVotes(complition: @escaping (String?) -> Void)
    
    func rateUp(shop: ShopModel,
                  complition: @escaping (Bool) -> Void)
    
    func rateDown(shop: ShopModel,
                  complition: @escaping (Bool) -> Void)
    
    func connectTelegram(
        complition: @escaping (String?) -> Void )
    
    func getUserInfo(
        complition: @escaping (UserInfoOfferModel?) -> Void)
    
    func updateUserInfo(userInfo: UserInfoOfferModel,
        complition: @escaping (Bool) -> Void)
}
