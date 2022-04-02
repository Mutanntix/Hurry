//
//  UserModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 24.03.2022.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var password: String
    var uid: String?
    
    func getUid() -> String {
        guard let currentUid = self.uid else { return "" }
        var newUid = ""
        
        for charachter in currentUid {
            switch charachter {
            case "\"":
                continue
            default:
                newUid.append(charachter)
            }
        }
        return newUid
    }
}
