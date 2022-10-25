//
//  BookingDetailsVC.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit
import Lightbox
class BookingDetailsVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    var bookingItem : Booking?
    var isShowCancel = false
    
    var bookingDetails : Booking? {
        didSet {
            
            var bookingtime = (bookingDetails?.ordertime_slot ?? "").changeTimeToFormat(frmFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy : hh.mm a")
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "dd MMM yyyy : hh.mm a"
            let date = dateFormatter.date (from: bookingtime)
            let interval = (date ?? Date()) - Date()
            if(bookingDetails?.order_status_label == "Pending") || (bookingDetails?.order_status_label == "Accepted") {
                if(interval.hour! > 1){
                    isShowCancel = true
                }else {
                    isShowCancel = false
                }
            }else {
                isShowCancel = false
            }
            self.tableView.reloadData()
        }
    }
    var isFromNotification = false
    var orderId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        fetchBookingData()
        /// `notification observser`
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBookings(notification:)), name: NotificationsObservers.bookingStatusObserver, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(orderStatusChanged), name: Notification.Name(rawValue: "OrderStatusChanged"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    @objc func orderStatusChanged() {
        fetchBookingData()
    }
    func setInterface(){
        type = .cart
        viewControllerTitle = bookingItem?.order_no
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    //MARK: - Methodes
    func fetchBookingData() {
        var parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","order_id" : bookingItem?.order_block_id ?? "" , "type" : "2"]
        
        if isFromNotification {
            parameters["order_id"] = orderId
        }
        BookingAPIManager.fetchUserBookingDetailsAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.bookingDetails = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
}
extension BookingDetailsVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension BookingDetailsVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isShowCancel){
        return 5
        }else {
        return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingDetailsHeaderCell") as! BookingDetailsHeaderCell
            cell.bookingItem = self.bookingDetails
            cell.selectionStyle = .none
            return cell
        } else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingServicesCell") as! BookingServicesCell
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            cell.populateServiceDetailsWith(booking: self.bookingDetails?.services)
            cell.selectionStyle = .none
            return cell
        }else if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingAddress") as! ShippingAddress
            let item = self.bookingDetails?.shipping_address?[0]
            cell.populateServiceDetailsWith(booking: item, staffDetail: self.bookingDetails?.staff_details)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsCell") as! PaymentDetailsCell
            cell.bookingItem = self.bookingDetails
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelBookingCell") as! CancelBookingCell
            cell.parent = self
            cell.bookingItem = self.bookingDetails
            cell.order_id = self.bookingItem?.order_block_id ?? ""
            if isFromNotification {
                cell.order_id = orderId
            }
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        
    }
}
extension BookingDetailsVC : CancelBookingCellDelegate {
    func refresh() {
        fetchBookingData()
    }
}
extension BookingDetailsVC : imagePresenterProtocol {
    func presentImages(images: [LightboxImage]) {
        let controller = LightboxController(images: images)
        controller.pageDelegate = self
        controller.dismissalDelegate = self
        // Use dynamic background.
        controller.dynamicBackground = true
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
}
extension BookingDetailsVC {
    
    @objc
    func refreshBookings(notification: Notification) {
        self.fetchBookingData()
    }
}

extension BookingDetailsVC: LightboxControllerPageDelegate {

  func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
    print(page)
  }
}
extension BookingDetailsVC: LightboxControllerDismissalDelegate {

  func lightboxControllerWillDismiss(_ controller: LightboxController) {
    // ...
  }
}
