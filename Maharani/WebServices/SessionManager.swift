//
//  SessionManager.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation
import UIKit
class SessionManager {
    class func getUserData() -> MHUser? {
        guard let data = UserDefaults.standard.object(forKey: "UserDetails") as? Data else { return nil }
        guard let userDict = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : Any] else { return nil }
        do {
            let json = try JSONSerialization.data(withJSONObject: userDict)
            let object = try JSONDecoder().decode(MHUser.self, from: json)
            return object
        } catch let err {
            print(err)
            return nil
        }
    }
    class func setUserData(dictionary: [String: Any]) {
        UserDefaults.standard.set( try? NSKeyedArchiver.archivedData(withRootObject: dictionary, requiringSecureCoding: false), forKey: "UserDetails")
        UserDefaults.standard.synchronize()
    }
    //// login
    open class func clearLoginSession() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set(nil, forKey: "UserDetails")
        UserDefaults.standard.set(nil, forKey: "googleImage")
        UserDefaults.standard.synchronize()
    }
    open class func isLoggedIn() -> Bool {
        guard let isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool else { return false }
        return isLoggedIn
    }
    
    class func setLoggedIn() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
    }
    
    open class func setFCMToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "FCM_Token")
        UserDefaults.standard.synchronize()
    }
    
    open class func getFCMToken() -> String? {
        guard let fcmToken = UserDefaults.standard.value(forKey: "FCM_Token") as? String else {
            return "abdhjef ekef kjwf wedfw"
        }
        return fcmToken
    }
    open class func getCartId() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
