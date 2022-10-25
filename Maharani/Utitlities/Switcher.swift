//
//  Switcher.swift
//  Kicks
//
//  Created by A2solution on 20/03/20.
//  Copyright © 2020 A2solution. All rights reserved.
//

import UIKit
import Foundation
import SideMenuSwift

class Switcher {
    static func updateRootVCToLogin() {
        let VC = Storyboard.authentication.instantiate(identifier: MHLoginViewController.self)
        let navVC = UINavigationController.init(rootViewController: VC)
        UIApplication.shared.setRoot(vc: navVC)
    }
    class func presentLogin(viewController: UIViewController?) {
        let  loginVC = UIStoryboard(name: Storyboard.authentication.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MHLoginViewController") as! MHLoginViewController
        let mainNavigationController = UINavigationController.init(rootViewController: loginVC)
        mainNavigationController.modalPresentationStyle = .fullScreen
        viewController?.present(mainNavigationController, animated: true, completion: nil)
    }
    static func gotoRegister(delegate: UIViewController?) {
        let VC = Storyboard.authentication.instantiate(identifier: MHRegisterViewController.self)
        delegate?.navigationController?.pushViewController(VC, animated: true)
    }
    static func gotoOTP(delegate: UIViewController?, token: String , phone :String) {
        let VC = Storyboard.authentication.instantiate(identifier: MHOTPViewController.self)
        VC.token = token
        VC.phone = phone
        if delegate is EditProfileVC {
            VC.isRegister = false
            VC.providesPresentationContextTransitionStyle = true
            VC.modalPresentationStyle = .overCurrentContext
            delegate?.tabBarController?.present(VC, animated: true)
        }else {
            VC.isRegister = true
            delegate?.navigationController?.pushViewController(VC, animated: true)
        }
    }
    static func gotoForgot(delegate: UIViewController?) {
        let VC = Storyboard.authentication.instantiate(identifier: MHForgotViewController.self)
        delegate?.navigationController?.pushViewController(VC, animated: true)
    }
    static func gotoTabbar() {
        let tabbarVC = TabbarController()
        let menuVC =  Storyboard.sidemenu.instantiate(identifier: SidemenuViewController.self)
        let menuNavVC = UINavigationController(rootViewController: menuVC)
        let sideMenuVC = SideMenuController(contentViewController: tabbarVC,
                                            menuViewController: menuNavVC)
        UIApplication.shared.setRoot(vc: sideMenuVC)
    }
    static func goToCMSPage(delegate: UIViewController?,cmsType:CMSType,pageTitle:String) {
        let  VC = UIStoryboard(name: Storyboard.cms.rawValue, bundle: nil).instantiateViewController(withIdentifier: "HECommonCMSPageViewController") as! HECommonCMSPageViewController
        VC.cmsType = cmsType
        VC.pageTitle = pageTitle
        let mainNavigationController = UINavigationController.init(rootViewController: VC)
        mainNavigationController.modalPresentationStyle = .fullScreen
        delegate?.present(mainNavigationController, animated: true, completion: nil)
    }
    static func goToFAQPage(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.cms.rawValue, bundle: nil).instantiateViewController(withIdentifier: "HEFaqViewController") as! HEFaqViewController
        let mainNavigationController = UINavigationController.init(rootViewController: VC)
        mainNavigationController.modalPresentationStyle = .fullScreen
        delegate?.present(mainNavigationController, animated: true, completion: nil)
    }
    static func goToContactPage(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.cms.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MHContactUsViewController") as! MHContactUsViewController
        let mainNavigationController = UINavigationController.init(rootViewController: VC)
        mainNavigationController.modalPresentationStyle = .fullScreen
        delegate?.present(mainNavigationController, animated: true, completion: nil)
    }
    static func goToCategorisPrice(delegate: UIViewController?, category : Category?) {
        let  VC = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CategoriesPricesVC") as! CategoriesPricesVC
        VC.selectedCategory = category
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToChooseDateTime(delegate: UIViewController?,cart : Cart?) {
        let  VC = UIStoryboard(name: Storyboard.cart.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChooseDateTimeVC") as! ChooseDateTimeVC
        let transition = CATransition()
        transition.duration = 0.5
        VC.cart = cart
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToCheckout(delegate: UIViewController?,cart : Cart?,timeSlot:String,description:String = "") {
        let  VC = UIStoryboard(name: Storyboard.cart.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
        VC.cart = cart
        VC.TimeSlot = timeSlot
        VC.userDescription = description
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToBookingDetails(delegate: UIViewController?,bookingItem:Booking?,isFromNotification:Bool = false,orderId:String = "") {
        let  VC = UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
        VC.bookingItem = bookingItem
        VC.orderId = orderId
        VC.isFromNotification = isFromNotification
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToBookingHistory(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MHBookingVC") as! MHBookingVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToEditProfile(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToChangePassword(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToAddressList(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.address.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddressListVC") as! AddressListVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToMyWallet(delegate: UIViewController?) {
        let  VC = UIStoryboard(name: Storyboard.MyWallet.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MHMyWalletViewController") as! MHMyWalletViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToEditAddress(delegate: UIViewController?,isEdit : Bool,selectedAddress :address) {
        let  VC = UIStoryboard(name: Storyboard.address.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EditAddressVC") as! EditAddressVC
        VC.isEdit = isEdit
        VC.address = selectedAddress
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToAddAddress(delegate: UIViewController?,isEdit : Bool) {
        let  VC = UIStoryboard(name: Storyboard.address.rawValue, bundle: nil).instantiateViewController(withIdentifier: "EditAddressVC") as! EditAddressVC
        VC.isEdit = isEdit
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToSearch(delegate: UIViewController?, category : String) {
        let  VC = UIStoryboard(name: Storyboard.search.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        VC.category_id = category
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    static func goToThankYou(delegate: UIViewController?, OrderId : String) {
        let  sortVC = UIStoryboard(name: Storyboard.cart.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ThankYouCartVC") as! ThankYouCartVC
        sortVC.orderNo = OrderId
        sortVC.providesPresentationContextTransitionStyle = true
        sortVC.modalPresentationStyle = .overCurrentContext
        delegate?.tabBarController?.present(sortVC, animated: true)
    }
    static func goToServiesDetails(delegate: UIViewController?, services : Services?) {
        let  VC = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ServicesDescVC") as! ServicesDescVC
        VC.selectedService = services
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = .fromRight
        delegate?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        delegate?.navigationController?.pushViewController(VC, animated: false)
    }
    
    static func gotoOTPFromRegister(delegate: UIViewController?, token: String , phone :String,email:String,password:String) {
        let VC = Storyboard.authentication.instantiate(identifier: MHOTPViewController.self)
        VC.token = token
        VC.phone = phone
        if delegate is EditProfileVC {
            VC.isRegister = false
            VC.providesPresentationContextTransitionStyle = true
            VC.modalPresentationStyle = .overCurrentContext
            delegate?.tabBarController?.present(VC, animated: true)
        }else {
            VC.isRegister = true
            VC.email = email
            VC.password = password
            delegate?.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}
