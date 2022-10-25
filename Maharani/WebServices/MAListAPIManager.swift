//
//  HEListAPIManager.swift
//  HireEmirati
//
//  Created by Albin Jose on 22/12/21.
//

import Foundation
import Alamofire

class MAListAPIManager {
    
    /// country List
    struct CountryListConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_country_list"
    }
    public class func countryListAPI(parameters: [String: String], completionHandler : @escaping(_ result: Country_Base) -> Void) {
        
        var config = CountryListConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Country_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }

    /// city List
    struct CityListConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_city_list"
    }
    public class func cityListAPI(parameters: [String: String], completionHandler : @escaping(_ result: City_Base) -> Void) {
        
        var config = CityListConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(City_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    /// city List
    struct AreaListConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_area_list"
    }
    
    public class func areaListAPI(parameters: [String: String], completionHandler : @escaping(_ result: Area_Base) -> Void) {
        
        var config = AreaListConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Area_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
}
