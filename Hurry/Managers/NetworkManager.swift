//
//  NetworkManager.swift
//  Hurry
//
//  Created by Мурад on 25.02.2022.
//

import Foundation
import Alamofire
import CoreData
import Network

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
    
    
    //MARK: WORKING WITH INTERNET CONNECTION AVAILABILITY
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown

    private let key = "user"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private var archiveURL: URL?

    private init() {
        if documentDirectory != nil {
            archiveURL = documentDirectory!.appendingPathComponent("User").appendingPathExtension("plist")
        }
        self.monitor = NWPathMonitor()
    }
    
    enum ConnectionType {
        case wifi
        case cellular
        case ehernet
        case unknown
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) { connectionType = .wifi }
        else if path.usesInterfaceType(.cellular) { connectionType = .cellular }
        else if path.usesInterfaceType(.wiredEthernet) { connectionType = .ehernet }
        else { connectionType = .unknown }
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
    
    func regUser(from login: String, password: String, completion: @escaping (Bool) -> Void) {
        var isUidAvailable = false
        
        guard let url = getUrl(for: .reg) else { return }
        var user = UserModel(login: login, password: password)
        
        guard login != "" && password != "" else { return }
        
        let params: Parameters = [
            "login": user.login,
            "password": user.password
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .failure(let error):
                completion(isUidAvailable)
                print(error)
            case .success(let data):
                isUidAvailable = true
                
                let userUid = String(decoding: data, as: UTF8.self)
                print(userUid)
                user.uid = userUid
                self.saveUser(user: user)
                completion(isUidAvailable)
            }
        }
    }
    
    func loginUser(from login: String, password: String, completion: @escaping (Bool) -> Void) {
        var isUidAvailable = false
        
        guard let url = getUrl(for: .login) else { return }
        var user = UserModel(login: login, password: password)
        
        guard login != "" && password != "" else { return }
        
        let params: Parameters = [
            "login": user.login,
            "password": user.password
        ]
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .failure(let error):
                completion(isUidAvailable)
                print(error)
            case .success(let data):
                isUidAvailable = true
                
                let userUid = String(decoding: data, as: UTF8.self)
                print(userUid)
                user.uid = userUid
                self.saveUser(user: user)
                completion(isUidAvailable)
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
    
    func forgotUserPassword(login: String) {
        guard let url = getUrl(for: .forgotPass) else { return }
        
        let params: Parameters = [
            "login": login
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default).validate().response { response in
            
            switch response.result {
                case .failure(let error):
                print(error)
                case .success:
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
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default).validate().response { response in
            
            switch response.result {
                
                case .failure(let error):
                print(error)
                case .success:
                self.saveUser(user: user)
                print("Success changed password")
            
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
