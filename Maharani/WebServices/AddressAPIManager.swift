//
//  AccountAPIManager.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import Foundation
import Alamofire

class AddressAPIManager {
    
    /// fetch user address
    struct FetchAddressInfoConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_shipping_address"
    }
    class func fetchUserAddressAPI(parameters: [String: String], completionHandler : @escaping(_ result: address_base) -> Void) {
        var config = FetchAddressInfoConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(address_base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    /// Delete user address
    struct DeleteAddressConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/delete_shipping_address"
    }
    class func DeleteUserAddressAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        var config = DeleteAddressConfig()
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
    
    /// add address
    struct EdiAddressService: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/update_shipping_address"
    }
    public class func EditAddressApi(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        var config = EdiAddressService()
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
    /// add address
    struct AddAddressService: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/add_shipping_address"
    }
    public class func SaveAddressApi(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        var config = AddAddressService()
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
