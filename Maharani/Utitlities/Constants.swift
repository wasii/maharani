//
//  Constants.swift
//  Pramo Pack
//
//  Created by Mac User on 21/08/19.
//  Copyright © 2019 Mac User. All rights reserved.
//

import Foundation
import UIKit

var mutiLoginMessage = "Your account is either suspended or currently being used in other device. Please login again to proceed further."
var deviceType = "iOS"

class Constants {
    static let shared: Constants = Constants()
    var languageBool: Bool = false
    
    //static let baseURL = "https://dx.co.ae/maharani/"
    static let baseURL = "https://maharanibeauty.com/"
    static let headers: [(String, String)] = [
        ("APP-USER", "bunyanik-app"),
        ("APP-PWD" , "b87c01a9f1fbc6a6d2960992eae27d1e")
    ]
}

enum Config {
    static let googleApiKey = "AIzaSyDpeMGQV5I2tOkgkUL4TQhdyHIbn68pSF0"
    static let googleSignInClientID = "381597737511-6c8tv3quk06c9rj6jh0dvhvvhp0dv287.apps.googleusercontent.com"
}

struct Storyboards {
    static let Main =  "Main"
    static let Authentication =  "Authentication"
    static let Notification =  "Notification"
    static let Account = "Account"
    static let Vacancies = "Vacancies"
    static let Search = "Search"
    static let CMS = "CMS"
    static let List = "List"
    static let message = "Message"
    static let ratingReviews = "RatingAndReviews"
    static let SideMenu = "SideMenu"
    static let filter = "Filter"
    static let candidates = "Candidates"
    static let Favourite = "Favourite"
}


struct AppFonts {
    static let RobotoRegular =  "Roboto-Regular"
    static let RobotoMedium =  "Roboto-Medium"
    static let RobotoBold =  "Roboto-Bold"
}

enum AppColor {
    static let primaryGreen = UIColor.UIColorFromHex(rgbValue: 0x00A79D)
    static let primaryBlue = UIColor.UIColorFromHex(rgbValue: 0x1B75BC)
    static let dark = UIColor.UIColorFromHex(rgbValue: 0x303030)
    static let LightGrey = UIColor.UIColorFromHex(rgbValue: 0x858585)
    static let Red = UIColor.UIColorFromHex(rgbValue: 0xac302d)
    static let Green = UIColor.UIColorFromHex(rgbValue: 0x4BD582)
    static let lightBlue = UIColor.UIColorFromHex(rgbValue: 0xEBF9FF)
    static let DarkGrey = UIColor.UIColorFromHex(rgbValue: 0x464646)
   // static let light = UIColor.UIColorFromHex(rgbValue: 0xac302d)
    
}
struct CmsKeys {
    static let ABOUT_US = "ABOUT_US"
    static let PRIVACY_POLICY = "PRIVACY_POLICY"
    static let TERMS_AND_CONDITION = "TERMS_AND_CONDITION"
    static let HELP_SUPPORT = "HELP_SUPPORT"
}

enum TargetType {
    case monthly
    case halfYearly
    case yearly
}
enum CommonAlertTitles {
    static let NoInternetMessage  = "Please check your internet connection"
}

struct NotificationsObservers {
    static let bookingStatusObserver = Notification.Name("BookingStatusUpdate")
}
