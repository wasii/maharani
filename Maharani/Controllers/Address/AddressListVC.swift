//
//  AddressListVC.swift
//  Maharani
//
//  Created by Zain on 14/01/2022.
//

import UIKit

class AddressListVC: BaseViewController {
    
    @IBAction func btnAddress(_ sender: Any) {
        Switcher.goToAddAddress(delegate: self,isEdit : false)
        
    }
    @IBOutlet weak var tableView: UITableView!
    var address : [address]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "My Address"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInterface()
    }
    func setInterface(){
       
        setuptable()
        fetchAddressData()
    }
    func setuptable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - Methodes
    func fetchAddressData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1"]
        AddressAPIManager.fetchUserAddressAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.address = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
    //MARK: - Methodes
    func DeleteAddressData(addressId : String) {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1",
            "address_id" : addressId]
        AddressAPIManager.DeleteUserAddressAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                Utilities.showSuccessAlert(message: response.message ?? "") {
                    self?.fetchAddressData()
                }
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
}
extension AddressListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard address?.count != 0 else {
            tableView.setEmptyView(title: "No Address Found", message: "", image:#imageLiteral(resourceName: "logo-small"))
            return 0
        }
        tableView.backgroundView = nil
        return address?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell") as! AddressListCell
        cell.parent = self
        cell.userAddress = self.address?[indexPath.row]
        cell.delegate = self
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension AddressListVC : AddressListCellDelegate {
    func deleteAddress(selectedAddress: address?) {
        
        self.DeleteAddressData(addressId: selectedAddress?.shiping_details_id ?? "")
    }
}
