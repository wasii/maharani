//
//  MHMyWalletViewController.swift
//  Maharani
//
//  Created by Albin Jose on 20/01/22.
//

import UIKit
import Stripe
class MHMyWalletViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalBalanceLbl: UILabel!
    @IBOutlet weak var amountTxt: UITextField!
    
    var secretkey = ""
    var paymentSheet: PaymentSheet?
    
    var myWalletData:TransactionData? {
        didSet {
            let total = Double((myWalletData?.wallet_total ?? "0"))
            if((total ?? 0.0) > 0){
            totalBalanceLbl.text = "AED " + (myWalletData?.wallet_total ?? "")
            }else {
                totalBalanceLbl.text = "AED " + "0"
            }
        }
    }
    var myTransactionList:[List_data]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        fetchMyWalletData()
    }
    //MARK: - Methods
    func setInterface() {
        type = .back
        viewControllerTitle = "My Wallet"
    }
    func fetchMyWalletData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? ""
        ]
        WalletAPIManager.WalletData(parameters: parameters) { [weak self] result in
            switch result.status {
            case "0","1" :
                self?.myWalletData = result.oData
                self?.myTransactionList = result.oData?.list_data
                
            default :
                Utilities.showWarningAlert(message:result.message ?? "" )
            }
        }
    }
    func initPayment() {
        if let amount = Int(amountTxt.text ?? "0") {
            if amount <= 1 {
                Utilities.showWarningAlert(message: "Minimum recharge amount is AED 2")
                return
            }
        }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "total_amount" : amountTxt.text ?? ""
        ]
        CartAPIManager.processPaymentAPi(parameters: parameters) { [weak self] result in
           switch result.status {
            case "1" :
               self?.secretkey = result.oData?.stripe_key ?? ""
               var configuration = PaymentSheet.Configuration()
               configuration.merchantDisplayName = "Maharani"
               if #available(iOS 13.0, *) {
                   configuration.style = .alwaysLight
               } else {
                   // Fallback on earlier versions
               }
               configuration.primaryButtonColor = UIColor.blue
               self?.paymentSheet = PaymentSheet(paymentIntentClientSecret: self?.secretkey ?? "", configuration: configuration)
               
               self?.paymentSheet?.present(from: self!) { paymentResult in
                 // MARK: Handle the payment result
                 switch paymentResult {
                 case .completed:
                   self?.rechargeWallet()
                 case .canceled:
                       print("User Cancelled")
                 case .failed(let error):
                   print(error.localizedDescription)
                   Utilities.showWarningAlert(message: "Payment Failed")
                 }
               }
            default:
                Utilities.showWarningAlert(message: result.message ?? "")
            }
        }
    }
    func rechargeWallet() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "amount" : amountTxt.text ?? ""
        ]
        WalletAPIManager.rechargeWalletAPI(parameters: parameters) { result in
            switch result.status {
            case "1" :
                Utilities.showSuccessAlert(message: result.message ?? "") {
                    self.amountTxt.text = ""
                    self.amountTxt.resignFirstResponder()
                    self.fetchMyWalletData()
                }
            default :
                Utilities.showWarningAlert(message: result.message ?? "")
            }
        }
    }
    //MARK: - Actions
    @IBAction func rechargeBtnAction(_ sender: Any) {
        if amountTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please add amount")
            return
        }
        initPayment()
    }
}

extension MHMyWalletViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MHMyWalletViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTransactionList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let transactionCells = tableView.dequeueReusableCell(withIdentifier: "MyTransactionsTableViewCell", for: indexPath) as? MyTransactionsTableViewCell else { return UITableViewCell() }
        transactionCells.configureCellWith(transactionData: myTransactionList?[indexPath.row])
        if(myTransactionList?.count == 1){
            transactionCells.viewMain.layer.cornerRadius = 10
        }else {
            if(indexPath.row == 0){
                transactionCells.viewMain.topMaskedCornerRadius = 10
            }else {
                if(indexPath.row == ((myTransactionList?.count ?? 0) - 1)){
                    transactionCells.viewMain.bottomMaskedCornerRadius = 10
                }
            }
        }
        return transactionCells
    }
}

