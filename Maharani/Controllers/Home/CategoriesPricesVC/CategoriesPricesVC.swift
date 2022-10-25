//
//  MHHomeVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit
import ImageSlideshow
import CHIPageControl
import FirebaseDatabase

private enum Section {
    case banner
    case price
}
class CategoriesPricesVC: BaseViewController {
    var selectedCategory : Category?
    var ServicesData:ServicesListData? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var keyword = ""
    @IBOutlet weak var tableView: UITableView!
    fileprivate let sections: [Section] = [
        .banner,
        .price,
    ]
    
    let tasksCount: Int = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
        categoryId = self.selectedCategory?.category_id ?? ""
        fetchSubCatData()
    }
    //MARK: - Methodes
    func fetchSubCatData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1",
            "category_id" :selectedCategory?.category_id ?? "",
            "keyword" : keyword]
        HomeAPIManager.GetSubCategoriesDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.ServicesData = response.oData
                
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    @IBAction func btnSearcg(_ sender: Any) {
        Switcher.goToBookingHistory(delegate: self)
    }
}
extension CategoriesPricesVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .banner:
            return 1
        default:
            guard ServicesData?.service_list?.count != 0 else {
                return 1
            }
            tableView.backgroundView = nil
            return self.ServicesData?.service_list?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSliderTableViewCell") as! HomeSliderTableViewCell
            cell.setupSlideShow(promotionBanner: self.ServicesData?.service_slider)
            return cell
        default:
            guard ServicesData?.service_list?.count != 0 else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoServiceTableViewCell") as! NoServiceTableViewCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryPriceCell") as! CategoryPriceCell
            cell.baseVc = self
            cell.subCat = self.ServicesData?.service_list?[indexPath.row]
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            if ServicesData?.service_list?.count != 0  {
                let item = ServicesData?.service_list?[indexPath.row]
                Switcher.goToServiesDetails(delegate: self, services: item)
            }
        }
    }
    
}
