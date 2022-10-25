//
//  SidemenuViewController.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 06/12/21.
//

import UIKit
import SideMenu

class SidemenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sideMenuTitleArray = ["About Us","Terms & Conditions","Privacy Policy","FAQs","Support","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
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
                //}
            default:
                Utilities.showWarningAlert(message: result.message ?? "")
            }
        }
    }
    
    func goToCMSPage(cmsType: CMSType,pageTitle: String) {
        Switcher.goToCMSPage(delegate: self,cmsType: cmsType,pageTitle: pageTitle)
    }
    
    func goToContactPage() {
        Switcher.goToContactPage(delegate: self)
    }
    func goToFaqPage() {
        Switcher.goToFAQPage(delegate: self)
    }
    //MARK: - Social actions
    @IBAction func instaBtnAction(_ sender: Any) {
        guard let insta =  UserDefaults.standard.string(forKey: "insta") else { return }
        Utilities.openUrl(urlString: insta)
    }
    @IBAction func twitterAction(_ sender: Any) {
        guard let twitter =  UserDefaults.standard.string(forKey: "twitter") else { return }
        Utilities.openUrl(urlString: twitter)
    }
    @IBAction func snapChatActions(_ sender: Any) {
        guard let faceBook =  UserDefaults.standard.string(forKey: "facebook") else { return }
        Utilities.openUrl(urlString: faceBook)
    }
    
}

extension SidemenuViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuTitleArray.count
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "SideMeuTableViewCell", for: indexPath) as! SideMeuTableViewCell
        menuCell.menuTitlelbl.text = sideMenuTitleArray[indexPath.row]
        switch indexPath.row {
        case sideMenuTitleArray.count - 1:
            if(SessionManager.isLoggedIn()){
                menuCell.menuTitlelbl.text = "Logout"
            }else {
                menuCell.menuTitlelbl.text = "Login"
            }
            menuCell.menuTitlelbl.textColor = Color.pink.color()
            menuCell.bottomSeparator.isHidden = false
        default:
            menuCell.menuTitlelbl.textColor = .white
            menuCell.bottomSeparator.isHidden = true
        }
        return menuCell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sideMenuTitleArray[indexPath.row]
        switch section {
        case "About Us":
            goToCMSPage(cmsType: .about, pageTitle: "About us")
            break
        case "Terms & Conditions":
            goToCMSPage(cmsType: .terms, pageTitle: "Terms and Conditions")
            break
        case "Privacy Policy":
            goToCMSPage(cmsType: .privacy, pageTitle: "Privacy Policy")
            break
        case "FAQs":
          goToFaqPage()
            break
        case "Support":
           goToContactPage()
            break
        case "Logout":
            if (SessionManager.isLoggedIn()){
                Utilities.showQuestionAlert(message: "Are you sure you want to logout?") {
                    self.callLogout()
                }
            }else {
                Switcher.presentLogin(viewController: self)
            }
            break
        default:
            break
        }
        
    }
}
extension SidemenuViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

