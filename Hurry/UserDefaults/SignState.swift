//
//  SignState.swift
//  Hurry
//
//  Created by Мурад Чеерчиев on 05.04.2022.
//

import Foundation

struct SignState {
    static var shared = SignState()
    
    private init() {}
    
    var state: LoginButtonState {
        get {
            LoginButtonState(rawValue: UserDefaults.standard.integer(forKey: "signState")) ?? .login
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "signState")
        }
    }
}
