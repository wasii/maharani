//
//  CMSAPIManager.swift
//  HireEmirati
//
//  Created by Albin Jose on 31/12/21.
//

import Foundation
import Alamofire

class CMSAPIManager {
    
    //// fetchcms
    struct FetchCMSConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cms/page"
    }
    class func fetchCMSAPI(parameters: [String: String], completionHandler : @escaping(_ result: CMSModel) -> Void) {
        var config = FetchCMSConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(CMSModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    //// fetchcms
    struct FetchPrivacyPolicyConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cms/privacy_policies"
    }
    class func fetchPrivacyAPI(parameters: [String: String], completionHandler : @escaping(_ result: privacy_Base) -> Void) {
        var config = FetchPrivacyPolicyConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(privacy_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    //// faq
    struct FetchFAQConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cms/faqs"
    }
    class func fetchFAQAPI(parameters: [String: String], completionHandler : @escaping(_ result: privacy_Base) -> Void) {
        var config = FetchFAQConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(privacy_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    //// contact us
    struct ContactUsConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/add_support"
    }
    class func contactUsAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralModel) -> Void) {
        var config = ContactUsConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(MAGeneralModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
}
