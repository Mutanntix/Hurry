//
//  FirstLaunch.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 08.04.2022.
//

import Foundation

public func isFirstLaunch() -> Bool {
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isFirstLaunch") {
        return false
    } else {
        defaults.set(false, forKey: "isFirstLaunch")
        return true
    }
}
