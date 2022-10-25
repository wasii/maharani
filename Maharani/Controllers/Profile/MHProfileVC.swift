//
//  MHProfileVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit

class MHProfileVC: BaseViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var logout: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var completed: UILabel!
    @IBOutlet weak var missed: UILabel!
    @IBOutlet weak var statsView: UIView!
    
    var profileData : Profile? {
        didSet {
            if let userImageStr = UserDefaults.standard.string(forKey: "googleImage") {
                userImage.sd_setImage(with: URL(string: userImageStr), placeholderImage: #imageLiteral(resourceName: "account-circle-large"))
            } else {
                userImage.sd_setImage(with: URL(string: profileData?.oData?.user_image ?? ""), placeholderImage: #imageLiteral(resourceName: "account-circle-large"))
            }
           
            name.text = profileData?.oData?.user_full_name ?? "GUEST"
            loc.text = profileData?.oData?.country_name ?? ""
            completed.text =  profileData?.total_completed ?? ""
            missed.text =  profileData?.total_missed ?? ""
            total.text =  profileData?.total_booking ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateData()
    }
    
    func setInterface(){
        type = .back
        viewControllerTitle = "My Profile"
        
    }
    func populateData() {
        
        if(SessionManager.isLoggedIn()){
            fetchUserInfoData()
            self.logout.text = "Logout"
            self.statsView.isHidden = false
        }else {
            name.text = "GUEST"
            loc.text = ""
            completed.text = ""
            missed.text = ""
            total.text = ""
            self.logout.text = "Login"
            self.statsView.isHidden = true
        }
        
        
    }
    
    //MARK: - Methodes
    func fetchUserInfoData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
                                          "language" : "1"]
        AccountAPIManager.fetchUserInfoAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.profileData = response
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    @IBAction func btnBooking(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
        Switcher.goToBookingHistory(delegate: self)
        }else {
            Switcher.presentLogin(viewController: self)
        }
    }
    @IBAction func btnEditProfile(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
            Switcher.goToEditProfile(delegate: self)
        }else {
            Switcher.presentLogin(viewController: self)
        }
        
    }
    @IBAction func btnChangePassword(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
            Switcher.goToChangePassword(delegate: self)
        }else {
            Switcher.presentLogin(viewController: self)
        }
        
    }
    @IBAction func btnAddresslist(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
            Switcher.goToAddressList(delegate: self)
        }else {
            Switcher.presentLogin(viewController: self)
        }
    }
    @IBAction func btnMyWalletAction(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
            Switcher.goToMyWallet(delegate: self)
        }else {
            Switcher.presentLogin(viewController: self)
        }
    }
    @IBAction func btnLogout(_ sender: Any) {
        if (SessionManager.isLoggedIn()){
            Utilities.showQuestionAlert(message: "Are you sure you want to logout?") {
                self.callLogout()
            }
        }else {
            Switcher.presentLogin(viewController: self)
        }
    }
    func callLogout() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "device_cart_id" : deviceId,
            "language" : "1"
        ]
        AuthenticationAPIManager.logoutAPI(parameters: parameters) { result in
            switch result.status {
            case "1" :
               // Utilities.showSuccessAlert(message: result.message ?? "") {
                    SessionManager.clearLoginSession()
                    Switcher.presentLogin(viewController: self)
              //  }
            default:
                Utilities.showWarningAlert(message: result.message ?? "")
            }
        }
    }
    
}
