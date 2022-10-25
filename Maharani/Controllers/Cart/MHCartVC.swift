//
//  MHCartVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit

class MHCartVC: BaseViewController {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartMainView: UIView!
    @IBOutlet weak var cartEmpty: UIView!
    @IBAction func continueBtn(_ sender: Any) {
        Switcher.goToChooseDateTime(delegate: self,cart :self.cart)
    }
    var cart : Cart? {
        didSet {
            cartCount = "\(cart?.cart_services?.count ?? 0)"
            total.text = "AED \(cart?.grand_total ?? "")"
            self.tableView.reloadData()
            if((cart?.cart_services?.count ?? 0) > 0){
                self.cartEmpty.isHidden = true
                self.cartMainView.isHidden = false
            }else {
                self.cartEmpty.isHidden = false
                self.cartMainView.isHidden = true
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .cart
        viewControllerTitle = "Cart"
        self.setuptable()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCartData()
    }
    func setuptable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.restore()
    }

    //MARK: - Methodes
    func fetchCartData() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","device_cart_id" : deviceId,"currency_code" :  "AED"]
        CartAPIManager.getUserCartDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.cart = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }

}
extension MHCartVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.cart_services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCells") as! cartCells
        cell.itemCart = cart?.cart_services?[indexPath.row]
        cell.delegate = self
        return cell
            

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return UITableView.automaticDimension
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
}

extension MHCartVC : cartCellsDelegate {
    func refresh() {
        fetchCartData()
    }
}
