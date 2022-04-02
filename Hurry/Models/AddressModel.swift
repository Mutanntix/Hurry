//
//  AddressModel.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 02.04.2022.
//

import Foundation

struct Address: Codable {
    let country: String
    let city: String
    let street: String
    let build: String
}
