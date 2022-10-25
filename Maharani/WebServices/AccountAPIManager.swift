//
//  AccountAPIManager.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import Foundation
import Alamofire

class AccountAPIManager {
    ////  change pwd
    struct ChangePasswordConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/change_password"
    }
    class func changePasswordAPI(parameters: [String: String], completionHandler : @escaping(_ result: Authentication_Base) -> Void) {
        var config = ChangePasswordConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
//    /// fetch company profile details
//    struct FetchCompanyDetailsConfig: APIConfiguration {
//        var parameters: [String : String] = [:]
//        var method: HTTPMethod = .post
//        var path = "webservices/vendor/get_company_details"
//    }
//    class func fetchCompanyDetailsAPI(parameters: [String: String], completionHandler : @escaping(_ result: CompanyDetails_Base) -> Void) {
//        var config = FetchCompanyDetailsConfig()
//        config.parameters = parameters
//        APIClient.apiRequest(request: config) { (result) in
//            do {
//                let json = try JSONSerialization.data(withJSONObject: result as Any)
//                let response = try JSONDecoder().decode(CompanyDetails_Base.self, from: json)
//                completionHandler(response)
//            } catch let err {
//                print(err)
//            }
//        }
//    }
//
//
//    /// update company profile
//    struct UpdateCompanyProfileConfig : UploadAPIConfiguration {
//        var images: [String : [UIImage?]]
//        var documents: [String : [Data?]]
//        var parameters: [String : String] = [:]
//        var method: HTTPMethod = .post
//        var path = "webservices/vendor/update_profile"
//    }
//    class func updateCompanyProfileAPI(documents:[String:[Data?]],images:[String : [UIImage?]],parameters: [String: String], completionHandler: @escaping(_ result: Login_Base) -> Void) {
//        var config = UpdateCompanyProfileConfig(
//            images : images ,
//            documents: documents
//        )
//        config.parameters = parameters
//        APIClient.multiPartRequest(request: config) { result in
//            do {
//                let json = try JSONSerialization.data(withJSONObject: result as Any)
//                let response = try JSONDecoder().decode(Login_Base.self, from: json)
//                switch response.status {
//                case "1":
//                    guard var dict = result?["oData"] as? [String:Any] else { return }
//                    dict["accessToken"] = response.accessToken ?? ""
//                    HESessionManager.setUserData(dictionary: dict)
//                default:
//                    break
//                }
//                completionHandler(response)
//            } catch let err {
//                print(err)
//            }
//        }
//    }
//
//    /// fetch employee profile details
//    struct FetchEmployeeDetailsConfig: APIConfiguration {
//        var parameters: [String : String] = [:]
//        var method: HTTPMethod = .post
//        var path = "webservices/user/get_employee_details"
//    }
//    class func fetchEmployeeDetailsAPI(parameters: [String: String], completionHandler : @escaping(_ result: EmployeeDetail_Base) -> Void) {
//        var config = FetchEmployeeDetailsConfig()
//        config.parameters = parameters
//        APIClient.apiRequest(request: config) { (result) in
//            do {
//                let json = try JSONSerialization.data(withJSONObject: result as Any)
//                let response = try JSONDecoder().decode(EmployeeDetail_Base.self, from: json)
//                completionHandler(response)
//            } catch let err {
//                print(err)
//            }
//        }
//    }
//
    /// update emplotee profile
    struct UpdateUserProfileConfig : UploadAPIConfiguration {
        var images: [String : [UIImage?]]
        var documents: [String : [Data?]]
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/update_profile"
    }
    class func updateUserProfileAPI(images:[String : [UIImage?]],parameters: [String: String], completionHandler: @escaping(_ result: Authentication_Base) -> Void) {
        var config = UpdateUserProfileConfig(
            images : images,
            documents: [:]
        )
        config.parameters = parameters
        APIClient.multiPartRequest(request: config) { result in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard var dict = result?["oData"] as? [String:Any] else { return }
                    let token = SessionManager.getUserData()?.accessToken ?? ""
                    dict["accessToken"] = token
                    SessionManager.setUserData(dictionary: dict)
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
        /// fetch user information
        struct FetchUserInfoConfig: APIConfiguration {
            var parameters: [String : String] = [:]
            var method: HTTPMethod = .post
            var path = "webservices/user/get_user_info"
        }
        class func fetchUserInfoAPI(parameters: [String: String], completionHandler : @escaping(_ result: Profile) -> Void) {
            var config = FetchUserInfoConfig()
            config.parameters = parameters
            APIClient.apiRequest(request: config) { (result) in
                do {
                    let json = try JSONSerialization.data(withJSONObject: result as Any)
                    let response = try JSONDecoder().decode(Profile.self, from: json)
                    completionHandler(response)
                } catch let err {
                    print(err)
                }
            }
        }
    
}
