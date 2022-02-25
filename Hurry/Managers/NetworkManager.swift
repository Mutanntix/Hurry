//
//  NetworkManager.swift
//  Hurry
//
//  Created by Мурад on 25.02.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    @objc public func getUserData(from login: String, password: String) {
        
        let user = UserModel(login: login, password: password)
        
        guard login != "" && password != "" else { return }
        guard let url = URL(string: "https://hurry-network.herokuapp.com/api/user/login") else { return }
        
        let params: Parameters = [
            "login": user.login,
            "password": user.password
        ]
            
            DispatchQueue.main.async {
                do {

                    AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
                        switch response.result {
                        case .failure(let error):
                            print(error)
                        case .success(let data):
                            let dataString = String(decoding: data, as: UTF8.self)
                            
                            print(dataString)
        
                    }
                }
            }
        }
    }
    
}
