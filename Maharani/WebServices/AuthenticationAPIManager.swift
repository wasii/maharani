//
//  AuthenticationAPIManager.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation
import Alamofire

class AuthenticationAPIManager {
    
    //// login
    struct LoginConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/login"
    }
    
    public class func loginAPI(parameters: [String: String], completionHandler : @escaping(_ result: Authentication_Base) -> Void) {
        var config = LoginConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard let dict = result?["oData"] as? [String:Any] else { return }
                    SessionManager.setLoggedIn()
                    SessionManager.setUserData(dictionary: dict)
                    UserDefaults.standard.set(nil, forKey: "googleImage")
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    //// Register
    struct RegisterConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/signup"
    }
    
    public class func RegisterAPI(parameters: [String: String], completionHandler : @escaping(_ result: Authentication_Base) -> Void) {
        var config = RegisterConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard var dict = result?["oData"] as? [String:Any] else { return }
                    dict["accessToken"] = response.accessToken ?? ""
                    UserDefaults.standard.set(nil, forKey: "googleImage")
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    //  OTP
    struct OTPConfig : APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/verify_otp"
    }
    class func OTPAPI(parameters: [String: String], completionHandler: @escaping(_ result: Authentication_Base) -> Void) {
        var config = OTPConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { result in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard var dict = result?["oData"] as? [String:Any] else { return }
                    dict["accessToken"] = response.accessToken ?? ""
                    SessionManager.setUserData(dictionary: dict)
                    SessionManager.setLoggedIn()
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    ///resendOTP
    struct resendOTPConfig : APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/resend_otp"
    }
    class func resendOTPAPI(parameters: [String: String], completionHandler: @escaping(_ result: Authentication_Base) -> Void) {
        var config = resendOTPConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { result in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard var dict = result?["oData"] as? [String:Any] else { return }
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    /// forgot password
    struct ForgotPasswordConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/forgot_password"
    }
    
    public class func forgotPasswordAPI(parameters: [String: String], completionHandler : @escaping(_ result: Authentication_Base) -> Void) {
        
        var config = ForgotPasswordConfig()
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
    
    /// social login
    struct UserSocialLoginConfig : APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/social_media_login"
    }
    class func socialLoginAPI(parameters: [String: String], completionHandler: @escaping(_ result: Authentication_Base) -> Void) {
        var config = UserSocialLoginConfig()
        config.parameters = parameters

        APIClient.apiRequest(request: config) { result in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Authentication_Base.self, from: json)
                switch response.status {
                case "1":
                    guard var dict = result?["oData"] as? [String:Any] else { return }
                    dict["accessToken"] = response.accessToken ?? ""
                    if let userImage = UserDefaults.standard.string(forKey: "googleImage") {
                        dict["user_image"] = userImage
                    }
                    SessionManager.setUserData(dictionary: dict)
                    SessionManager.setLoggedIn()
                default:
                    break
                }
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    /// forgot password
    struct logoutApiConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/logout"
    }
    
    public class func logoutAPI(parameters: [String: String], completionHandler : @escaping(_ result: Authentication_Base) -> Void) {
        
        var config = logoutApiConfig()
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
}
