//
//  AppDelegate.swift
//  Opium
//
//  Created by Albin Jose on 13/12/21.
//

import UIKit
import IQKeyboardManager
import GoogleMaps
import GooglePlaces
import SideMenuSwift
import GoogleSignIn
import Firebase
import Stripe
import Siren

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        sidemenuPreferences()
        IQKeyboardManager.shared().isEnabled = true
        FirebaseApp.configure()
        requestNotificationAuth(application: application)
        GMSPlacesClient.provideAPIKey(Config.googleApiKey)
        GMSServices.provideAPIKey(Config.googleApiKey)
       // StripeAPI.defaultPublishableKey = "pk_test_51JKGJYCUTRQ9leSEEWuSzUtFxvJv1oYunqUuUSx27c6jrKIfKoyS7GKRwfnZZCc4IWtqbVmZnLULcjDBHxb4uMEw00QELaDQZD"
        StripeAPI.defaultPublishableKey = "pk_live_51KPX12AlQmndlnR12bjSvivKCxiKKq2TkkYRsgc4Ows93WgwQjeOIRkehNaWFmrLKAbzRCM4w1qlTHRkUHmLPpU6009jBE1US8"
     //   StripeAPI.defaultPublishableKey = "pk_test_51KPX12AlQmndlnR1aYLHJhlazK7BboT8IWtg3OiM3EuXosYNBe1GDGkmEfDCSB8lwc7beO6kiyG65D7OrODzAnEN00papJoVfC"

        forceUpdateSetup()
        let tabbarVC = TabbarController()
        let menuVC =  Storyboard.sidemenu.instantiate(identifier: SidemenuViewController.self)
        let menuNavVC = UINavigationController(rootViewController: menuVC)
        let sideMenuVC = SideMenuController(contentViewController: tabbarVC,
                                            menuViewController: menuNavVC)
        self.window?.rootViewController = sideMenuVC
        self.window?.makeKeyAndVisible()
       
        return true
        
    }
    func forceUpdateSetup() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .critical,
                                          showAlertAfterCurrentVersionHasBeenReleasedForDays: 1)
        siren.presentationManager = PresentationManager(forceLanguageLocalization: .english)
        siren.wail()
    }
    func application(
        _ app: UIApplication,open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            var handled: Bool
            handled = GIDSignIn.sharedInstance.handle(url)
            if handled {
                return true
            }
            return false
        }
    func sidemenuPreferences() {
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width * 0.80
    }
}

extension AppDelegate:  MessagingDelegate, UNUserNotificationCenterDelegate {
    func requestNotificationAuth(application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // [START set_messaging_delegate]
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("APNs token retrieved: \(deviceToken)")
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        UserDefaults.standard.set(deviceTokenString, forKey: "user_device_token")
        UserDefaults.standard.synchronize()
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
        print("Token is here   \(String(describing: Messaging.messaging().fcmToken))")
        print("Token is here   \(String(describing: Messaging.messaging().apnsToken))")
        if let token = Messaging.messaging().fcmToken {
            storeFCMToken(token: token)
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "")")
        storeFCMToken(token: fcmToken ?? "")
    }
    func storeFCMToken(token: String) {
        if SessionManager.getFCMToken() == nil {
            SessionManager.setFCMToken(token: token)
        } else {
            guard let fcmSavedToken = SessionManager.getFCMToken() else { return }
            if fcmSavedToken == token {
            } else {
                SessionManager.setFCMToken(token: token)
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // 1. Print out error if PNs registration not successful
        print("Failed to register for remote notifications with error: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "OrderStatusChanged"), object: nil)
        completionHandler([.alert, .badge, .sound])
    }
    // Handle notification messages after display notification is tapped by the user.
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        handleUserNotifications(userInfo: userInfo)
        
        completionHandler()
    }
    
    func handleUserNotifications(userInfo: [AnyHashable: Any]) {
        
        ///  `notification observer` to update the status
        NotificationCenter.default.post(name: NotificationsObservers.bookingStatusObserver, object: nil)
        
        guard let type = userInfo["type"] as? String else { return }
        switch type.lowercased() {
        case "order-placed","booking-accepted","booking_completed","order-cancelled","order-time-slot","order-staff-assign":
            guard let tabVC = self.window?.rootViewController as? SideMenuController else { return }
            guard let tabBarVC = tabVC.contentViewController as? TabbarController else { return }
            tabBarVC.selectedIndex = 1
            guard let promoNav = tabBarVC.viewControllers?[1] as? UINavigationController else { return }
            let detailsVC = UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
            guard let promoId =  userInfo["orderID"] as? String else {
                return
            }
            detailsVC.orderId = promoId
            detailsVC.isFromNotification = true
            promoNav.pushViewController(detailsVC, animated: true)
            
        default:
            guard let tabVC = self.window?.rootViewController as? SideMenuController else { return }
            guard let tabBarVC = tabVC.contentViewController as? TabbarController else { return }
            tabBarVC.selectedIndex = 3
            guard let promoNav = tabBarVC.viewControllers?[3] as? UINavigationController else { return }
            let detailsVC = UIStoryboard(name: Storyboard.notification.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NotificationDetailsViewController") as! NotificationDetailsViewController
            guard let notificationId =  userInfo["notificationID"] as? String else {
                return
            }
            detailsVC.notificationId = notificationId
            promoNav.pushViewController(detailsVC, animated: true)
        }
        
    }
    
}

