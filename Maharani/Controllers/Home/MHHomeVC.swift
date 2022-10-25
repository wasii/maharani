//
//  MHHomeVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit
import ImageSlideshow
import CHIPageControl

private enum Section {
    case banner
    case categories
}
class MHHomeVC: BaseViewController {
    
    var homeData:HomeListData? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var cart : Cart? {
        didSet {
            cartCount = "\(cart?.cart_services?.count ?? 0)"
        }
    }
    var homeBaseData:HomeBaseData?
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let sections: [Section] = [
        .banner,
        .categories,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
        self.fetchHomeData()
        fetchCartData()
        fetchHomeBaseData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    //MARK: - Methodes
    func fetchHomeData() {
        let parameters:[String:String] = [
                                          "language" : "1"]
        HomeAPIManager.GetHomeDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.homeData = response.oData
                self?.tableView.reloadData()
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }

    func fetchCartData() {
        guard let deviceId = SessionManager.getCartId() else { return }
        var parameters:[String:String] = [
            "language" : "1","device_cart_id" : deviceId,"currency_code" :  "AED"]
        if SessionManager.isLoggedIn() {
            parameters["access_token"] = SessionManager.getUserData()?.accessToken ?? ""
        }
        CartAPIManager.getUserCartDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.cart = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
    func fetchHomeBaseData() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "language" : "1","device_cart_id" : deviceId]
        HomeAPIManager.GetHomeBasicDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.homeBaseData = response.oData
                UserDefaults.standard.set(self?.homeBaseData?.instagram, forKey: "insta")
                UserDefaults.standard.set(self?.homeBaseData?.twitter, forKey: "twitter")
                UserDefaults.standard.set(self?.homeBaseData?.linkedin, forKey: "linkdn")
                UserDefaults.standard.set(self?.homeBaseData?.facebook, forKey: "facebook")
                UserDefaults.standard.set(self?.homeBaseData?.youtube, forKey: "youtube")
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
extension MHHomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .banner:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSliderTableViewCell") as! HomeSliderTableViewCell
            cell.setupSlideShow(promotionBanner: self.homeData?.pramotinal_banners)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell") as! DataTableViewCell
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            cell.baseVc = self
            cell.populateServiceDetailsWith(categories: self.homeData?.category_list)
            return cell
        }
            

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}
