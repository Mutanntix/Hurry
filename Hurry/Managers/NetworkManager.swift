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
import CoreText

class NetworkManager {
    static let shared = NetworkManager()
    
    
    //MARK: -WORKING WITH INTERNET CONNECTION AVAILABILITY
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown

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
        case ethernet
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
        else if path.usesInterfaceType(.wiredEthernet) { connectionType = .ethernet }
        else { connectionType = .unknown }
    }
    
    var urlComponents = URLComponents()
    
    private func getUrl(for request: RequestType) -> URLComponents {
        
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
        case .cartPut:
            self.urlComponents.path = "/api/user/cart"
        case .cartGet:
            self.urlComponents.path = "/api/user/cart"
        case .cartDelete:
            self.urlComponents.path = "/api/user/cart"
        case .info:
            break
        case .sendOrder:
            self.urlComponents.path = "/api/user/sendOrder"
        case .rateUp:
            self.urlComponents.path = "/api/user/rateUp"
        case .rateDown:
            self.urlComponents.path = "/api/user/rateDown"
        case .votes:
            self.urlComponents.path = "/api/user/votes"
        case .shops:
            self.urlComponents.path = "/api/bus/shops"
        case .checkInfo:
            break
        }
        return urlComponents
    }
    
    func regUser(login: String, password: String, completion: @escaping (Bool) -> Void) {
        var isUidAvailable = false
        let urlComponents = getUrl(for: .reg)
        guard let url = urlComponents.url else { return }
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
    
    func loginUser(login: String, password: String, completion: @escaping (Bool) -> Void) {
        var isUidAvailable = false
        
        let urlComponents = getUrl(for: .login)
        guard let url = urlComponents.url else { return }
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

        let urlComponents = getUrl(for: .check)
        guard let url = urlComponents.url else { return }
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
        let urlComponents = getUrl(for: .forgotPass)
        guard let url = urlComponents.url else { return }
        
        let params: Parameters = [
            "login": login
        ]
        AF.request(url, method: .put,
                   parameters: params,
                   encoding: JSONEncoding.default).validate().response { response in
            
            switch response.result {
                case .failure(let error):
                print(error)
                case .success:
                print("Success")
            }
        }
    }
    
    func changeUserPassword(newPass: String) {
        let urlComponents = getUrl(for: .changePass)
        guard let url = urlComponents.url else { return }
        guard var user = fetchUser() else { return }
        
        user.password = newPass
        let uid = user.getUid()
        let params: Parameters = [
            "uid": uid,
            "newPass": user.password
        ]
        
        AF.request(url,
                   method: .put,
                   parameters: params,
                   encoding: JSONEncoding.default).validate().response { response in
            
            switch response.result {
                
                case .failure(let error):
                print(error)
                case .success:
                self.saveUser(user: user)
                print("Success changed password")
            
            }
        }
    }
    
    func getShops(complition: @escaping ([ShopModel]) -> Void) {
        let urlComponents = getUrl(for: .shops)
        guard let url = urlComponents.url else { return }
        let params: Parameters = [
            "skip": "0",
            "limit": "0"
        ]
        
        let request = AF.request(url, method: .get, parameters: params,
                                         encoding: URLEncoding.queryString,
                                         headers: nil,
                                         interceptor: nil,
                                         requestModifier: nil)
        
        request.validate().responseData { responseData in
            
            switch responseData.result {
                case .failure(let error):
                print("error: ", error)
                complition([])
                case .success(let data):
                do {
                    guard let attemptShops = try? JSONDecoder()
                        .decode([ShopModel].self, from: data)
                    else { return }
                    complition(attemptShops)
                }
            }
        }
    }
    
    func basketPut(shop: ShopModel, indexPath: IndexPath) {
        let products = shop.menu
        var urlComponents = getUrl(for: .cartPut)
        guard let user = fetchUser() else { return }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "bid", value: shop.id.description),
            URLQueryItem(name: "uid", value: user.getUid())
        ]
        guard let url = urlComponents.url else { return }
        
        let params: Parameters = [
            "title": products[indexPath.item].title,
            "option": products[indexPath.item].option,
            "price": products[indexPath.item].price
        ]
        let request = AF.request(url,
                                 method: .put,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        
        request.validate().response { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(_):
                return
            }
        }
    }
    
    func getCurrentBasket(complition: @escaping ([[String: Product]]?) -> Void) {
        let urlComponents = getUrl(for: .cartGet)
        guard let url = urlComponents.url else { return }
        guard let user = fetchUser() else { return }
        let params: Parameters = [
            "uid": user.getUid()
        ]
        let request = AF.request(url,
                                 method: .get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        request.validate().responseData { responseData in
            
            switch responseData.result {
                case .failure(let error):
                print("error: ", error)
                complition(nil)
                case .success(let data):
                do {
                    let currentBasket = try JSONDecoder().decode([[String: Product]].self, from: data)
                    complition(currentBasket)
                } catch let error {
                    print(error)
                    complition(nil)
                }
            }
        }
    }
    
    func clearBasket(complition: @escaping (Bool) -> Void) {
        let urlComponents = getUrl(for: .cartDelete)
        guard let url = urlComponents.url else { return }
        guard let user = fetchUser() else { return }
        let params: Parameters = [
            "uid": user.getUid()
        ]
        let request = AF.request(url,
                                 method: .delete,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        
        request.validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    complition(false)
                    print("delete cart error: \(error.localizedDescription)")
                case .success(_):
                    complition(true)
            }
        }
    }

    func sendOrder(basket: [[String: Product]],
                   shop: ShopModel,
                   secretWord: String,
                   pickUpTime: String,
                   total: Int,
                   complition: @escaping (Bool) -> Void) {
        var urlComponents = getUrl(for: .sendOrder)
        guard let user = fetchUser() else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "uid", value: user.getUid())
        ]
        guard let url = urlComponents.url else { return }
        guard let chatId = shop.tgChatId else { return }
        let sum = "\(total)руб"
        
        let order = OrderModel(chatId: chatId,
                               order: basket,
                               pTime: pickUpTime,
                               bid: shop.id,
                               sum: sum,
                               sw: secretWord)
        
        let request = AF.request(url,
                                 method: .post,
                                 parameters: order,
                                 encoder: JSONParameterEncoder(),
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        request.validate()
            .response { response in
                switch response.result {
                case .failure(_):
                    complition(false)
                case .success(_):
                    complition(true)
            }
        }
    }
    
    func getVotes(complition: @escaping (String?) -> Void) {
        let urlComponents = getUrl(for: .votes)
        guard let url = urlComponents.url else { return }
        guard let user = fetchUser() else { return }
        let params: Parameters = [
            "uid": user.getUid()
        ]
        let request = AF.request(url,
                                 method: .get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        
        request.validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    complition(nil)
                    print(
                        "Cant get votes: \(error.localizedDescription)")
                case .success(let data):
                    guard let data = data else {
                        complition(nil)
                        return
                    }
                    let votes = String(data: data, encoding: .utf8)
                    complition(votes)
            }
        }
    }
    
    func rateUp(shop: ShopModel,
                complition: @escaping (Bool) -> Void) {
        let urlComponents = getUrl(for: .rateUp)
        guard let url = urlComponents.url else { return }
        guard let user = fetchUser() else { return }
        let params: Parameters = [
            "uid": user.getUid(),
            "bid": shop.id
        ]
        let request = AF.request(url,
                                 method: .put,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        
        request.validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    complition(false)
                    print("Rate up error: \(error.localizedDescription)")
                case .success(_):
                    complition(true)
            }
        }
    }
    
    func rateDown(shop: ShopModel,
                  complition: @escaping (Bool) -> Void) {
        let urlComponents = getUrl(for: .rateDown)
        guard let url = urlComponents.url else { return }
        guard let user = fetchUser() else { return }
        let params: Parameters = [
            "uid": user.getUid(),
            "bid": shop.id
        ]
        let request = AF.request(url,
                                 method: .put,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: nil,
                                 interceptor: nil,
                                 requestModifier: nil)
        
        request.validate()
            .response { response in
                switch response.result {
                case .failure(let error):
                    complition(false)
                    print("delete cart error: \(error.localizedDescription)")
                case .success(_):
                    complition(true)
            }
        }
    }

    
    
    //MARK: -WORKING WITH USERMODEL
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
    
    func deleteUser() {
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
