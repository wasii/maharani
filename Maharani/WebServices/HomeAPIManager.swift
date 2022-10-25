//
//  AuthenticationAPIManager.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation
import Alamofire

class HomeAPIManager {
    
    //// Get Home categories and banners
    struct HomeDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/home/get_service_category_list"
    }
    public class func GetHomeDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: Home_Base) -> Void) {
        
        var config = HomeDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Home_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////SubCategories APi
    struct SubCategoriesDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/home/get_service_list_by_categry"
    }
    public class func GetSubCategoriesDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: Services_Base) -> Void) {
        
        var config = SubCategoriesDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Services_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ///Home base data
    struct HomeBasicConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/home"
    }
    public class func GetHomeBasicDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: HomeBaseData_Base) -> Void) {
        
        var config = HomeBasicConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(HomeBaseData_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
}
