//
//  Storyboard.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit

enum Storyboard: String {
    case authentication = "Authentication"
    case main = "Main"
    case sidemenu = "Sidemenu"
    case profile = "Profile"
    case notification = "Notification"
    case updatePassword = "UpdatePassword"
    case aboutUs = "About"
    case faqs = "FaQs"
    case packages = "Packages"
    case editSkill = "EditSkills"
    case taskCompleted = "TaskCompleted"
    case ReviewandRating = "ReviewRatingPage"
    case MyRequests = "MyRequests"
    case terms = "Terms"
    case privacy = "PrivacyPolicy"
    case help = "Help"
    case services = "Services"
    case home = "Home"
    case booking = "Booking"
    case cart = "Cart"
    case address = "Address"
    case search = "Search"
    case cms = "CMS"
    case MyWallet = "MyWallet"
    
    

    func instantiate<T>(identifier: T.Type) -> T {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else {
            fatalError("No such view controller found")
        }
        return viewcontroller
    }
}

