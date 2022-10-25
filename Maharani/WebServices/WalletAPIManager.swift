//
//  WalletAPIManager.swift
//  Maharani
//
//  Created by Albin Jose on 20/01/22.
//

import Foundation
import Alamofire

class WalletAPIManager {
    /// wallet details
    struct MyWalletConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_wallet_details"
    }
    public class func WalletData(parameters: [String: String], completionHandler : @escaping(_ result: Transaction_Base) -> Void) {
        
        var config = MyWalletConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Transaction_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    /// wallet recharge
    struct WalletRechargeConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/wallet_recharge"
    }
    public class func rechargeWalletAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        
        var config = WalletRechargeConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(MAGeneralForAddressModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
}
