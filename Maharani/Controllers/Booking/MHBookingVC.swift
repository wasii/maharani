//
//  MHBookingVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit

class MHBookingVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pendingImg: UIImageView!
    @IBOutlet weak var completedImg: UIImageView!
    @IBOutlet weak var pending: UILabel!
    @IBOutlet weak var completed: UILabel!
    var booking : BookingData? {
        didSet {
            
            self.tableView.reloadData()
        }
    }
    
    
    var selectedTab = 0
    var filter_status = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerTitle = "Booking History"
        
        /// `notification observser`
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBookings(notification:)), name: NotificationsObservers.bookingStatusObserver, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInterface()
    }
    func setInterface(){
        type = .cart
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setTabBar()
    }
    func setTabBar() {
        pendingImg.backgroundColor = UIColor.clear
        completedImg.backgroundColor = UIColor.clear
        pending.textColor = .black
        completed.textColor = .black
        
        if(selectedTab == 0){
            filter_status = "0"
            pendingImg.backgroundColor = Color.pink.color()
            pending.textColor = Color.pink.color()
        }else {
            filter_status = "4"
            completedImg.backgroundColor = Color.pink.color()
            completed.textColor = Color.pink.color()
        }
        fetchBookingData()
        
    }
    
    @IBAction func pendingBtn(_ sender: UIButton) {
        selectedTab = 0
        setTabBar()
    }
    @IBAction func completedBtn(_ sender: UIButton) {
        selectedTab = 1
        setTabBar()
    }
    
    //MARK: - Methodes
    func fetchBookingData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","filter_status" : filter_status]
        BookingAPIManager.fetchUserBookingAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.booking = response.oData
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
}
extension MHBookingVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = booking?.result?[indexPath.row]
        Switcher.goToBookingDetails(delegate: self,bookingItem: item)
    }
}

extension MHBookingVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               
        guard booking?.result?.count != 0 else {
            tableView.setEmptyView(title: "No Jobs Found", message: "", image:#imageLiteral(resourceName: "cart-empty"))
            return 0
        }
        tableView.backgroundView = nil
        return booking?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell") as! BookingCell
        cell.bookingItem = booking?.result?[indexPath.row]
        cell.selectionStyle = .none
            return cell
       
        
    }
}

extension MHBookingVC {
    
    @objc
    func refreshBookings(notification: Notification) {
        self.fetchBookingData()
    }
}
