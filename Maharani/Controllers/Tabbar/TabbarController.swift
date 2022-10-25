//
//  TabbarController.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import DatePickerDialog
import Firebase
var notificationCount = "0" {
    didSet {
        NotificationCenter.default.post(name: Notification.Name("notificationNumberChanged"), object: nil)
    }
}
var cartCount = "0" {
    didSet {
        NotificationCenter.default.post(name: Notification.Name("cartNumberChanged"), object: nil)
    }
}

class TabbarController: UITabBarController {
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let cartCountView = UIView()
    var cartCountLabel: UILabel = {
        let cartCountLabel = UILabel()
        cartCountLabel.font = UIFont(name: AppFonts.RobotoBold, size: 12)
        cartCountLabel.textColor = UIColor.black
        return cartCountLabel
        
    }()
    var userData: MHUser?
    var customTabBarView: UIView = UIView()
    
    let centerButton = UIButton(type: .custom)
    
    let cartHearBeatAnimationGroup: CAAnimationGroup = {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let group = CAAnimationGroup()
        group.duration = 2.7
        group.repeatCount = 1
        group.animations = [pulse1]
        return group
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationChanged), name: Notification.Name("notificationNumberChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginStatusChanged), name: Notification.Name("loginStatusChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartChanged), name: Notification.Name("cartNumberChanged"), object: nil)
        view.backgroundColor = .white
        self.delegate = self
        
        setupTabbar()
        addCustomTabBarView()
        addCenterItem()
        addViewControllers()
        setupNotificationCountObserver()
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    @objc func cartChanged() {
        cartCountLabel.text = cartCount
        if cartCount == "0" {
           cartCountView.isHidden = true
        } else {
            cartCountView.isHidden = false
            centerButton.layer.add(cartHearBeatAnimationGroup, forKey: "pulse")
        }
        
    }
    @objc func loginStatusChanged() {
        print("changed///")
    }
    
    @objc func notificationChanged() {
      //  notificationCountLabel.text = notificationCount
        if notificationCount == "0" {
        //   notificationCountView.isHidden = true
        } else {
          //  notificationCountView.isHidden = false
         //   notificationButton.layer.add(notificationHearBeatAnimationGroup, forKey: "pulse")
        }

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateTabbarFrame()
    }
    
    private func setupTabbar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.pink.color()], for: .selected)
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    private func addCustomTabBarView() {
        let imageView = UIImageView(image: UIImage(named: "tabbar-background"))
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        imageView.layer.shadowOpacity = 0.10
        imageView.layer.shadowRadius = 10.0
        
        let containerStack = UIStackView(arrangedSubviews: [imageView, bottomView])
        containerStack.axis = .vertical
        
        customTabBarView = containerStack
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    private func updateTabbarFrame() {
        var bottomOffset: CGFloat = 0
        if view.safeAreaInsets.bottom > 0 {
            bottomOffset = view.safeAreaInsets.bottom
        } else {
            bottomOffset = 32
        }
        tabBar.frame.size.height = tabBar.frame.size.height + bottomOffset
        tabBar.frame.origin.y = tabBar.frame.origin.y - bottomOffset
        customTabBarView.frame = tabBar.frame
    }
    
    func addViewControllers() {
        self.viewControllers = [home, booking, cart, notifications, profile]
    }
    
    func addCenterItem() {
        centerButton.addColorShadow = true
        centerButton.addTarget(self, action: #selector(centerItemTapped), for: .touchUpInside)
        centerButton.setBackgroundImage(#imageLiteral(resourceName: "cart").withRenderingMode(.alwaysOriginal), for: .normal)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        centerButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        view.addSubview(centerButton)
        
        cartCountView.backgroundColor = .red
        cartCountView.layer.cornerRadius = 20/2
        cartCountView.isUserInteractionEnabled = false
        cartCountLabel.textColor = .white
        if cartCount == "0" {
            cartCountView.isHidden = true
        } else {
            cartCountView.isHidden = false
        }
        cartCountLabel.text = "\(cartCount)"
        cartCountLabel.adjustsFontSizeToFitWidth = true
        cartCountView.addSubview(cartCountLabel)
        cartCountLabel.translatesAutoresizingMaskIntoConstraints = false
        cartCountLabel.centerXAnchor.constraint(equalTo: cartCountView.centerXAnchor, constant: 0).isActive = true
        cartCountLabel.centerYAnchor.constraint(equalTo: cartCountView.centerYAnchor, constant: 0).isActive = true
        view.addSubview(cartCountView)
        cartCountView.translatesAutoresizingMaskIntoConstraints = false
        cartCountView.trailingAnchor.constraint(equalTo: centerButton.trailingAnchor, constant: -2).isActive = true
        cartCountView.centerYAnchor.constraint(equalTo: centerButton.topAnchor, constant: 10).isActive = true
        cartCountView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cartCountView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.centerXAnchor.constraint(equalTo: centerButton.centerXAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: centerButton.bottomAnchor, constant: tabBar.frame.size.height - 20).isActive = true
    }
    
    @objc func centerItemTapped() {
        set(selectedIndex: 2)
    }
    
    func setCenterSelected() {
        centerButton.setBackgroundImage(#imageLiteral(resourceName: "cart").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func setCenterUnselected() {
        centerButton.setBackgroundImage(#imageLiteral(resourceName: "cart").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func set(selectedIndex index : Int) {
        _ = self.tabBarController(self, shouldSelect: self.viewControllers![index])
        selectedIndex = index
    }
    
    var home: UINavigationController {
        let VC = Storyboard.home.instantiate(identifier: MHHomeVC.self)
        let tabBarItem = UITabBarItem(title: "HOME", image: #imageLiteral(resourceName: "home_unselected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "home_selected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        VC.tabBarItem = tabBarItem
        return UINavigationController.init(rootViewController: VC)
    }
    
    var booking: UINavigationController {
        let VC = Storyboard.booking.instantiate(identifier: MHBookingVC.self)
        let tabBarItem = UITabBarItem(title: "BOOKING", image: #imageLiteral(resourceName: "booking_unslected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "booking_icon").withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        VC.tabBarItem = tabBarItem
        return UINavigationController.init(rootViewController: VC)
    }
    
    var cart: UINavigationController {
        let VC = Storyboard.cart.instantiate(identifier: MHCartVC.self)
        let tabBarItem = UITabBarItem(title: "CART", image: UIImage(), selectedImage: nil)
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        VC.tabBarItem = tabBarItem
        return UINavigationController.init(rootViewController: VC)
    }
    
    var notifications: UINavigationController {
        let VC = Storyboard.notification.instantiate(identifier: MHNotificationVC.self)
        let tabBarItem = UITabBarItem(title: "NOTIFICATIONS", image: #imageLiteral(resourceName: "notification_unselected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "notificaiton_selected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        VC.tabBarItem = tabBarItem
        return UINavigationController.init(rootViewController: VC)
    }
    
    var profile: UINavigationController {
        let VC = Storyboard.profile.instantiate(identifier: MHProfileVC.self)
        let tabBarItem = UITabBarItem(title: "PROFILE", image: #imageLiteral(resourceName: "profile_unselected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "profile_selected").withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        VC.tabBarItem = tabBarItem
        return UINavigationController.init(rootViewController: VC)
    }
}

extension TabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        setCenterUnselected()

        guard let navigationVC = viewController as? UINavigationController else { return true }
        
        switch navigationVC.viewControllers.first {
        case is MHCartVC:
            setCenterSelected()
        case is MHNotificationVC, is MHBookingVC:
            if !SessionManager.isLoggedIn() {
                Switcher.presentLogin(viewController: self)
            }
            return SessionManager.isLoggedIn()
        default:
            break
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabbarTransition(viewControllers: tabBarController.viewControllers)
    }
    @objc func setupNotificationCountObserver()  {
        if SessionManager.isLoggedIn() {
            userData = SessionManager.getUserData()
        }else{ return }
        //  userData = SessionManager.getUserData()
        
        guard let userId = userData?.firebase_user_key, userId != "" else { return }
        
        guard let tabItems = self.tabBar.items else { return }
        let notificationTabItem = tabItems[3]
        notificationTabItem.badgeValue = nil
        
        Database.database().reference().child("Notifications").child(userId).observe(.childAdded, with: { snapshot in
            if let value = snapshot.value as? [String:Any], let read = value["read"] as? String, read == "0" {
                if let badgeValue = notificationTabItem.badgeValue,
                   let value = Int(badgeValue) {
                    notificationTabItem.badgeValue = String(value + 1)
                } else {
                    notificationTabItem.badgeValue = "1"
                }
                NotificationCenter.default.post(name: Notification.Name("newRequestRecieved"), object: nil)
            }
            
        })
        Database.database().reference().child("Notifications").child(userId).observe(.childChanged, with: { snapshot in
            if let value = snapshot.value as? [String:Any], let read = value["read"] as? String, read == "1" {
                if let badgeValue = notificationTabItem.badgeValue,
                   let value = Int(badgeValue) {
                    if value - 1 <= 0 {
                        notificationTabItem.badgeValue = nil
                    } else {
                        notificationTabItem.badgeValue = String(value - 1)
                    }
                } else {
                    notificationTabItem.badgeValue = "1"
                }
                
            }
        })
        
        Database.database().reference().child("Notifications").child(userId).observe(.childRemoved, with: { snapshot in
            if let value = snapshot.value as? [String:Any], let read = value["read"] as? String, read == "0" {
                if let badgeValue = notificationTabItem.badgeValue,
                   let value = Int(badgeValue) {
                    if value - 1 <= 0 {
                        notificationTabItem.badgeValue = nil
                    } else {
                        notificationTabItem.badgeValue = String(value - 1)
                    }
                } else {
                    notificationTabItem.badgeValue = "1"
                }
                
            }
        })
    }
}
