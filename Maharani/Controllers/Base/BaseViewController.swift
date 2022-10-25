//
//  BaseViewController.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import SideMenu
import SDWebImage
enum ViewControllerType {
    case home
    case cart
    case title
    case back
    case popups
}


class BaseViewController: UIViewController {
    var type: ViewControllerType = .back
    var categoryId = ""
    var titleLabel: UILabel?
    
    
    var viewControllerTitle: String? {
        didSet {
            titleLabel?.text = viewControllerTitle ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        view.backgroundColor = Color.blue.color()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        solidNavigationBar()
        
        switch type {
        case .home:
            setupHomeBarButtonItems()
        case .cart:
            setupCartBarButtonItems()
        case .title:
            setupTitleBarButtonItems()
        case .back:
            setupBackBarButtonItems()
        case .popups:
            setupBackWithoutRightBarButtonItems()
        }
    }
    
    func solidNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
       if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
        }
        
    }
    
    
    
    func setupHomeBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addSidemenu()
        
        navigationItem.rightBarButtonItems = []
        addSearch()
    }
    func setupCartBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addBackButton()
        addTitleLabel()
        navigationItem.rightBarButtonItems = []
        addProfileImage()
    }
    
    func setupTitleBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addTitleLabel()
        
        navigationItem.rightBarButtonItems = []
        addSidemenu()
        addSearch()
    }
    
    func setupBackBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addBackButton()
        addTitleLabel()
        navigationItem.rightBarButtonItems = []
        addProfileImage()
    }
    func setupBackWithoutRightBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        addBackButton()
        addTitleLabel()
        navigationItem.rightBarButtonItems = []
       // addProfileImage()
    }
    
    func addTitleLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            titleLabel.text = viewControllerTitle ?? ""
            titleLabel.font = AppFont.bold.size(22)
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        }
    }
    func addProfileImage() {
        let profileImageView = UIImageView()
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.sd_setImage(with: URL(string: SessionManager.getUserData()?.user_image ?? ""), placeholderImage: #imageLiteral(resourceName: "account-circle-large"))
        profileImageView.backgroundColor = .clear
        profileImageView.layer.cornerRadius = 20
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
        
        let stack = UIStackView(arrangedSubviews: [profileImageView])
        stack.spacing = 0
        let barButton = UIBarButtonItem(customView: stack)
        navigationItem.rightBarButtonItems?.append(barButton)
    }
    func addLogo(logoImage: UIImage) {
        let logoImageView = UIImageView()
        logoImageView.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width/3).isActive = true
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        let logoBarButton = UIBarButtonItem(customView: logoImageView)
        if let _ = navigationItem.leftBarButtonItems {
            navigationItem.leftBarButtonItems?.append(logoBarButton)
        } else {
            navigationItem.leftBarButtonItems = [logoBarButton]
        }
    }
    func addBackButton() {
        let backButton = UIButton()
       // backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 27).isActive = true
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: backButton))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    @objc func backButtonAction() {
       
        if let _ = navigationController?.popViewController(animated: true) {
            
        } else {
            navigationController?.tabBarController?.selectedIndex = 0
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    func addSearch() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120.0, height: 60.0))
        button.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        let image = #imageLiteral(resourceName: "search")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems?.append(barButton)
    }
    //MARK: - Side Menu
    func setupSideMenu() {
        let sideMenuVC = UIStoryboard(name: Storyboard.sidemenu.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SidemenuViewController") as! SidemenuViewController
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: sideMenuVC)
        menuLeftNavigationController.menuWidth = self.view.frame.size.width * 0.80
        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        menuLeftNavigationController.allowPushOfSameClassTwice = false
        menuLeftNavigationController.presentationStyle = .menuSlideIn
        menuLeftNavigationController.pushStyle = .default
        menuLeftNavigationController.statusBarEndAlpha = 0
        menuLeftNavigationController.presentationStyle.presentingEndAlpha = 0.4
        menuLeftNavigationController.presentationStyle.onTopShadowColor = UIColor.black
        menuLeftNavigationController.presentationStyle.onTopShadowOffset = .zero
        menuLeftNavigationController.presentationStyle.menuStartAlpha = 0.5
        menuLeftNavigationController.presentationStyle.backgroundColor = UIColor.black
    }
    func addSidemenu() {
        let sideMenuButton = UIButton()
        sideMenuButton.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        sideMenuButton.setImage(#imageLiteral(resourceName: "sidemenu-white"), for: .normal)
        sideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        sideMenuButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sideMenuButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sideMenuButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: sideMenuButton))
        
    }
    
    
    
    @objc func searchAction() {
        Switcher.goToSearch(delegate: self.navigationController?.visibleViewController, category: categoryId)
    }
    
    @objc func sideMenuAction() {
        guard let leftMenuNC = SideMenuManager.default.leftMenuNavigationController else { return }
        if parent != nil {
            self.parent?.present(leftMenuNC, animated: true, completion: nil)
        } else {
            self.present(leftMenuNC, animated: true, completion: nil)
        }
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
            
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

