//
//  CheckOutVC.swift
//  Maharani
//
//  Created by Zain on 12/01/2022.
//

import UIKit
import Stripe
import SwiftUI


class CheckOutVC: BaseViewController {
    var cart : Cart?
    var totalAmount: String?
    var TimeSlot = ""
    var myAddress : [address]? {
        didSet {
            self.populateAddress()
        }
    }
    var myWalletData:TransactionData? {
        didSet {
//            let total = Double((myWalletData?.wallet_total ?? "0"))
//            if((total ?? 0.0) > 0){
//            totalBalanceLbl.text = "AED " + (myWalletData?.wallet_total ?? "")
//            }else {
//                totalBalanceLbl.text = "AED " + "0"
//            }
        }
    }
    var coponDiscount : CheckOut? {
        didSet {
            servicesFee.text = "AED \(coponDiscount?.sub_total ?? "")"
            discout.text = "AED \(coponDiscount?.coupon_discount ?? "")"
            var totalPrice = (Double(cart?.grand_total ?? "0") ?? 0) - (Double(coponDiscount?.coupon_discount ?? "0") ?? 0)
            totalPrice += Double(self.trasportAmount) ?? 0.0
            total.text = "AED \(totalPrice)"
            selectedCoupongId = coponDiscount?.coupon_id ?? ""
            setTotal = "\(totalPrice)"
        }
    }
    var Order : PlaceOrder? {
        didSet {
            Switcher.goToThankYou(delegate: self, OrderId:Order?.order_no ?? "" )
        }
    }
    @IBOutlet weak var servicesFee: UILabel!
    @IBOutlet weak var discout: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var coponField: UITextField!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cashView: UIView!
    @IBOutlet weak var WalletView: UIView!
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var WalletBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var addAddressView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var transportAmountLabel: UILabel!
    
    var selectedPaymentType = "1"
    var selectedCoupongId = ""
    var selectedAddresId = ""
    var selectedAreaId = ""
    var trasportAmount = ""
    var userDescription = ""
    var setTotal = "0"
    
    var secretkey = ""
    var paymentSheet: PaymentSheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .cart
        viewControllerTitle = "Checkout"
        populateData()
        addBtn.setTitle("", for: .normal)
        collectionView.register(UINib.init(nibName: "AddressCollectionCell", bundle: nil), forCellWithReuseIdentifier: "AddressCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAddressData()
        fetchMyWalletData()
    }
    
    func populateData () {
        self.totalAmount = self.cart?.grand_total
        self.selectedCoupongId = ""
        var discount = 0.0
        for item in cart?.cart_services ?? [] {
            discount = discount + Double(item.coupon_discount!)!
        }
        var totalDis = Double(cart?.grand_total ?? "0")! - discount
        totalDis += Double(self.trasportAmount) ?? 0.0
        servicesFee.text = "AED \(cart?.sub_total ?? "")"
        discout.text = "AED \(discount)"
        total.text = "AED \(totalDis)"
        setTotal = "\(totalDis)"
    }
    func populateAddress () {
       
        if(myAddress?.count == 0){
            height.constant = 0
            addAddressView.isHidden = false
            addAddressView.isHidden = true
        }else {
            height.constant = 160
            addAddressView.isHidden = true
        }
      //  self.transportAmountLabel.text = "AED \(myAddress?.first?.transport_amount ?? "0")"
       // self.trasportAmount = myAddress?.first?.transport_amount ?? "0"
        //self.selectedAreaId = myAddress?.first?.area_id ?? "0"
//        if var total = Double(self.totalAmount ?? "0.0") {
//            if let transport = Double(myAddress?.first?.transport_amount ?? "0") {
//                total = total + transport
//                self.cart?.grand_total = "\(total)"
//                self.total.text = "AED \(total)"
//            }
//        }
        collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    @IBAction func paymentType(_ sender: UIButton) {
        cardView.layer.borderColor = Color.black.color().cgColor
        cashView.layer.borderColor = Color.black.color().cgColor
        WalletView.layer.borderColor = Color.black.color().cgColor
        cardBtn.setTitleColor(Color.black.color(), for:.normal)
        cashBtn.setTitleColor(Color.black.color(), for:.normal)
        WalletBtn.setTitleColor(Color.black.color(), for:.normal)
        switch sender.tag {
        case 1001:
            cardView.layer.borderColor = Color.pink.color().cgColor
            cardBtn.setTitleColor(Color.pink.color(), for:.normal)
            selectedPaymentType = "1"
        case 1002:
            cashView.layer.borderColor = Color.pink.color().cgColor
            cashBtn.setTitleColor(Color.pink.color(), for:.normal)
            selectedPaymentType = "2"
        default:
            WalletView.layer.borderColor = Color.pink.color().cgColor
            WalletBtn.setTitleColor(Color.pink.color(), for:.normal)
            selectedPaymentType = "3"
        }
        
        
    }
    @IBAction func applyCoupon(_ sender: UIButton) {
        if(self.coponField.text == ""){
            Utilities.showWarningAlert(message: "Missing empty field")
        }else {
            ApplyCoponData()
        }
    }
    @IBAction func Pay(_ sender: UIButton) {
        switch selectedPaymentType {
        case "1" :
            if(isValidForm()){
              initPayment()
            }
        default:
            if(isValidForm()){
               PlaceOrder()
            }
        }
    }
    @IBAction func addAddressBtn(_ sender: UIButton) {
        Switcher.goToAddAddress(delegate: self, isEdit: false)
    }
    //MARK: - Methodes
    func fetchAddressData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1"]
        AddressAPIManager.fetchUserAddressAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.myAddress = response.oData
               
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    func fetchMyWalletData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? ""
        ]
        WalletAPIManager.WalletData(parameters: parameters) { [weak self] result in
            switch result.status {
            case "0","1" :
                self?.myWalletData = result.oData
               
                
            default :
                Utilities.showWarningAlert(message:result.message ?? "" )
            }
        }
    }
    func ApplyCoponData() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "device_cart_id" : deviceId,
            "coupon_code" : self.coponField.text ?? "",
            "language" : "1"]
        CartAPIManager.CheckOutData(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.coponDiscount = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? ""){
                    self?.coponDiscount = nil
                    self?.populateData()
                }
            }
        }
    }
    
    func isValidForm() -> Bool {
        let grandtotal = Double(self.cart?.grand_total ?? "0.0")
        if selectedPaymentType == "" {
            Utilities.showWarningAlert(message: "Please select payment method")
            return false
        }
        if selectedPaymentType == "2" {
            let totalWallet = Double((myWalletData?.wallet_total ?? "0"))
            if((grandtotal ?? 0) > (totalWallet ?? 0)){
                Utilities.showWarningAlert(message: "Insufficient balance in wallet")
                return false
            }
        }
        if ((grandtotal ?? 0) < 100) {
            Utilities.showWarningAlert(message: "Minimum order amount is AED 100")
            return false
        }
        
        
        if myAddress?.count == 0{
            Utilities.showQuestionAlert(message: "Please add address") {
                Switcher.goToAddAddress(delegate: self, isEdit: false)
            }
            return false
        }
        
        if selectedAddresId == "" {
            Utilities.showWarningAlert(message: "Please select address")
            return false
        }
        if SessionManager.getUserData()?.phone_number == "" {
            Utilities.showSuccessAlert(message: "Please add phone no") {
                Switcher.goToEditProfile(delegate: self)
            }
            return false
        }
        
        return true
    }
    
    func initPayment() {
        var parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "total_amount" : self.cart?.grand_total ?? "0.0"
        ]
        if var total = Double(self.cart?.grand_total ?? "0.0") {
            let transport = Double(self.trasportAmount) ?? 0.0
            total = (total + transport) - (Double(coponDiscount?.coupon_discount ?? "0") ?? 0)
            parameters["total_amount"] = total.description
        }
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
                   self?.PlaceOrder()
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
    func PlaceOrder() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "coupon_code" : self.coponField.text ?? "",
            "shipping_address_id" : selectedAddresId,
            "payment_type" : self.selectedPaymentType,
            "timeslot" : self.TimeSlot,
            "coupon_id" : self.selectedCoupongId,
            "user_description" : self.userDescription,
            "language" : "1",
            "area_id": self.selectedAreaId,
            "transport_amount": self.trasportAmount]
        //  (area_id, transport_amount)
        CartAPIManager.PlaceOrderAPi(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.Order = response.oData
            case "3" :
                Switcher.goToMyWallet(delegate: self)
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
}
extension CheckOutVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAddress?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCollectionCell", for: indexPath) as? AddressCollectionCell else { return UICollectionViewCell() }
        cell.selectedId = self.selectedAddresId
        cell.userAddress = myAddress?[indexPath.row]
        cell.parent = self
        
        return cell
    }
    
    
}
extension CheckOutVC:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 180, height:155)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = myAddress?[indexPath.row]
        self.selectedAddresId = item?.shiping_details_id ?? ""
        self.selectedAreaId = item?.area_id ?? ""
        self.trasportAmount = item?.transport_amount ?? ""
        self.transportAmountLabel.text = "AED \(item?.transport_amount ?? "0")"
        if item?.transport_amount == "" {
            self.transportAmountLabel.text = "AED 00.00"
        }
        if var total = Double(self.cart?.grand_total ?? "0") {
            if let transport = Double(item?.transport_amount ?? "0") {
                total = (total + transport) - (Double(coponDiscount?.coupon_discount ?? "0") ?? 0)
                //self.cart?.grand_total = "\(total)"
                self.total.text = "AED \(total)"
            }
        }
        self.collectionView.reloadData()
    }
    
}
