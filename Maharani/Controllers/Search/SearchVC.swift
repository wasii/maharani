//
//  SearchVC.swift
//  Maharani
//
//  Created by Zain on 15/01/2022.
//

import UIKit

class SearchVC: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var category_id  = ""
    var keyword = ""
    var ServicesData:[Services]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        setInterface()
        // Do any additional setup after loading the view.
    }
    func setInterface(){
        type = .back
        viewControllerTitle = "Search Services"
        searchBar.placeholder = "Search Service"
        tableView.setEmptyView(title: "Search Service", message: "", image:#imageLiteral(resourceName: "empty-search"))
        
        searchBar.backgroundColor = UIColor.clear
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .white
        
    }
    //MARK: - Methods
    @objc func callSearch() {
        fetchSubCatData()
    }
    
    //MARK: - Methodes
    func fetchSubCatData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1",
            "category_id" :category_id,
            "keyword" : keyword]
        HomeAPIManager.GetSubCategoriesDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.ServicesData = response.oData?.service_list
                
            default:
                self?.ServicesData?.removeAll()
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
}
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard ServicesData?.count != 0 else {
            tableView.setEmptyView(title: "No Service Found", message: "", image:#imageLiteral(resourceName: "empty-search"))
            return 0
        }
        if(self.ServicesData != nil){
        tableView.backgroundView = nil
        }
        return self.ServicesData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryPriceCell") as! CategoryPriceCell
        cell.baseVc = self
        cell.subCat = self.ServicesData?[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = ServicesData?[indexPath.row]
        Switcher.goToServiesDetails(delegate: self, services: item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // to limit network activity, reload half a second after last key press.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.callSearch), object: nil)
        keyword = searchBar.text ?? ""
        self.perform(#selector(self.callSearch), with: nil, afterDelay: 0.5)
        
        if searchBar.text?.trimmingCharacters(in: .whitespaces) == "" {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.callSearch), object: nil)
            ServicesData?.removeAll()
        }
        
    }
}
