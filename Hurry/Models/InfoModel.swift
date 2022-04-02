//
//  InfoModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 02.04.2022.
//

import Foundation

struct Info: Codable {
    let title: String
    let currency: String
    let addr: Address
    let secretWord: String
}
