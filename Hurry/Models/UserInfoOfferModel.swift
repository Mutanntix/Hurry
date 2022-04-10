//
//  UserInfoOfferModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 10.04.2022.
//

import Foundation

struct UserInfoOfferModel: Codable {
    var info: UserInfoModel
    let tgChatId: Int?
    
    func updateUserInfo(nick: String,
                        drink: String,
                        contry: String,
                        city: String)
    -> UserInfoOfferModel? {
        guard let newUserInfo = UserInfoModel(nick: nick,
                                        drink: drink,
                                        country: contry,
                                        city: city)
        else { return nil }
        let newUserInfoOffer =
        UserInfoOfferModel(info: newUserInfo,
                           tgChatId: self.tgChatId)
        return newUserInfoOffer
    }
}
