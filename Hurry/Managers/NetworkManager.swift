//
//  NetworkManager.swift
//  Hurry
//
//  Created by Мурад on 25.02.2022.
//

import Foundation
import Alamofire
import CoreData
import CoreVideo

enum RequestType {
    case reg
    case login
    case check
    case connect
    case forgotPass
    case changePass
    case cart
    case info
    case sendOrder
    case rateUp
    case rateDown
    case votes
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let key = "user"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private var archiveURL: URL?
    
    private init() {
        if documentDirectory != nil {
            archiveURL = documentDirectory!.appendingPathComponent("User").appendingPathExtension("plist")
        }
    }
    
    var urlComponents = URLComponents()
    
    private func getUrl(for request: RequestType) -> URL? {
        
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "hurry-network.herokuapp.com"
        
        switch request {
        case .reg:
            self.urlComponents.path = "/api/user/reg"
        case .login:
            self.urlComponents.path = "/api/user/login"
        case .check:
            self.urlComponents.path = "/api/user/check"
        case .connect:
            break
        case .forgotPass:
            self.urlComponents.path = "/api/user/forgotPass"
        case .changePass:
            self.urlComponents.path = "/api/user/changePass"
        case .cart:
            break
        case .info:
            break
        case .sendOrder:
            break
        case .rateUp:
            break
        case .rateDown:
            break
        case .votes:
            break
        }
        return urlComponents.url ?? nil
    }
    
    func regUser(from login: String, password: String) {
        
        guard let url = getUrl(for: .reg) else { return }
        var user = UserModel(login: login, password: password)
        
        guard login != "" && password != "" else { return }
        
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
                            let userUid = String(decoding: data, as: UTF8.self)
                            print(userUid)
                            user.uid = userUid.description
                            
                            //self.saveUser(user: user)
                    }
                }
            }
        }
    }
    
    func loginUser(from login: String, password: String) {
        
        guard let url = getUrl(for: .login) else { return }
        var user = UserModel(login: login, password: password)
        
        guard login != "" && password != "" else { return }
        
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
                            let userUid = String(decoding: data, as: UTF8.self)
                            print(userUid)
                            user.uid = userUid.description
                            
                            self.saveUser(user: user)
                    }
                }
            }
        }
    }
    
    func checkUID(completion: @escaping (Bool) -> Void) {
        var isUidAvailable = false

        guard let url = getUrl(for: .check) else { return }
        guard let user = fetchUser() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion(isUidAvailable)
            }
            return
        }
        let uid = user.getUid()
        
        let params: Parameters = ["uid": uid]
        
        let request = AF.request(url, method: .get, parameters: params,
                                         encoding: URLEncoding.queryString,
                                         headers: nil,
                                         interceptor: nil,
                                         requestModifier: nil)
        
        
        request.validate().responseData { responseData in
            
            switch responseData.result {
                case .failure(let error):
                completion(isUidAvailable)
                print("error: ", error)
                case .success(let data):
                if data.count == 2 {
                    isUidAvailable = true
                }
                completion(isUidAvailable)
            }
        }
    }
    
    func forgotUserPassword() {
        guard let url = getUrl(for: .forgotPass) else { return }
        guard let user = fetchUser() else { return }
        
        let params: Parameters = [
            "login": user.login
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: URLEncoding.queryString).validate().response { response in
            
            switch response.result {
                
                case .failure(let error):
                print(error)
                case .success:
                self.saveUser(user: user)
                print("Success")
            
            }
        }
    }
    
    func changeUserPassword(newPass: String) {
        guard let url = getUrl(for: .changePass) else { return }
        guard var user = fetchUser() else { return }
        user.password = newPass
        let uid = user.getUid()
        
        let params: Parameters = [
            "uid": uid,
            "newPass": user.password
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: URLEncoding.queryString).validate().response { response in
            
            switch response.result {
                
                case .failure(let error):
                print(error)
                case .success:
                self.saveUser(user: user)
                print("Success")
            
            }
        }
    }

    
    
    //MARK: WORKING WITH USERMODEL
    private func saveUser(user: UserModel) {
        guard let data = try? PropertyListEncoder().encode(user) else { return }
        
        if archiveURL != nil {
            try? data.write(to: archiveURL!, options: .noFileProtection)
        }
    }
    
    private func fetchUser() -> UserModel? {
        if archiveURL != nil {
            guard let data = try? Data(contentsOf: archiveURL!) else { return nil }
            guard let user = try? PropertyListDecoder().decode(UserModel.self, from: data) else { return nil }
            
            return user
        }
        return nil
    }
    
    private func deleteUser() {
        let user = UserModel(login: "", password: "", uid: nil)
        guard let data = try? PropertyListEncoder().encode(user) else { return }
        
        if archiveURL != nil {
            try? data.write(to: archiveURL!, options: .noFileProtection)
        }
    }
}



//MARK: SINGLETON EXTENSION
extension NetworkManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
