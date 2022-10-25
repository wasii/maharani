//
//  MHNotificationVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit
import FirebaseDatabase
class MHNotificationVC: BaseViewController,Refreshable {
    @IBOutlet weak var clearAllView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearAllBtn: UIButton!
    
    var refreshControl: UIRefreshControl?
    var hasFetchedOnce = false
    var lastKey: String?
    var hasFetchedAll = false
    var isFetching = false
    
    let refNotifications = Database.database().reference().child("Notifications")
    var notificationArray: [NotificationModel] = []
    
    var userData: MHUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshNotifications), name: Notification.Name(rawValue: "OrderStatusChanged"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: - Methods
    func setInterface(){
        type = .back
        viewControllerTitle = "Notificaion"
        self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        userData = SessionManager.getUserData()
        installRefreshControl()
        clearAllBtn.setTitle("", for: .normal)
    }
    func handleRefresh(_ sender: UITableView) {
        refreshControl?.endRefreshing()
        refreshNotifications()
    }
    
    @objc func refreshNotifications() {
        lastKey = nil
        notificationArray.removeAll()
        tableView.reloadData()
        fetchNotifications()
    }
    @objc func fetchNotifications() {
        isFetching = true

        guard let userId = userData?.firebase_user_key, userId != "" else { return }
        
        var query = DatabaseQuery()
        if let last = lastKey {
            query = refNotifications.child(userId).queryOrderedByKey().queryEnding(atValue: last).queryLimited(toLast: 11)
        } else {
            query = refNotifications.child(userId).queryOrderedByKey().queryLimited(toLast: 11)
        }
        
        query.observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let `self` = self else { return }
            Utilities.hideIndicatorView()
            guard snapshot.exists(), let notifications = snapshot.children.allObjects as? [DataSnapshot] else {
                print("Child does not exist")
                self.hasFetchedOnce = true
                self.isFetching = false
                self.tableView.reloadData()
                return
            }
            
            if snapshot.childrenCount < 11 {
                self.hasFetchedAll = true
            }
            
            var tempNotifications: [NotificationModel] = []
            
            for item in notifications {
                guard let value = item.value as? [String: Any] else { continue }
                do {
                    let json = try JSONSerialization.data(withJSONObject: value)
                    let notification = try JSONDecoder().decode(NotificationModel.self, from: json)
                    notification.key = item.key
                    tempNotifications.insert(notification, at: 0)
                } catch {
                   print(error)
                }
            }
            
            self.hasFetchedOnce = true
            self.isFetching = false
            
            self.lastKey = tempNotifications.last?.key
            
            if !self.hasFetchedAll {
                tempNotifications.removeLast()
            }
            
            self.notificationArray.append(contentsOf: tempNotifications)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func showClearNotificationsAlert() {
        Utilities.showQuestionAlert(message: "Are you sure want to clear all notifications?".KSlocalized()) { [weak self] in
            self?.clearNotifications()
        }
    }
    
    func clearNotifications() {
        guard let userId = userData?.firebase_user_key else { return }
        self.refNotifications.child(userId).setValue(nil)
        notificationArray.removeAll()
        tableView.reloadData()
        clearAllView.isHidden = true
    }
    
    func removeNotification(index: Int) {
        guard let userId = userData?.firebase_user_key else { return }
        guard let notificationId = notificationArray[index].key else { return }
        refNotifications.child(userId).child(notificationId).removeValue()
        notificationArray.remove(at: index)
        if notificationArray.count == 0 {
            clearAllView.isHidden = true
        }
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
    }
    //MARK: - Actions
    @IBAction func clearAllAction(_ sender: Any) {
        showClearNotificationsAlert()
    }
    
}
extension MHNotificationVC:UITableViewDelegate{
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
        let notification = notificationArray[indexPath.row]
        switch notificationArray[indexPath.row].notificationType ?? "" {
        case "order-placed","booking-accepted","booking_completed","order-cancelled","order-time-slot","order-staff-assign":
            Switcher.goToBookingDetails(delegate: self, bookingItem: nil, isFromNotification: true, orderId: notificationArray[indexPath.row].orderID ?? "")
        default :
            let detailsVC = UIStoryboard(name: Storyboard.notification.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NotificationDetailsViewController") as! NotificationDetailsViewController
            detailsVC.notificationId = notification.key
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension MHNotificationVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard notificationArray.count != 0 else {
            tableView.setEmptyView(title: "No Notifications Found", message: "Looks like you haven't received any notifications yet", image: #imageLiteral(resourceName: "logo-small"))
            clearAllView.isHidden = true
            return 0
        }
        tableView.backgroundView = nil
        clearAllView.isHidden = false
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard notificationArray.indices.contains(indexPath.row) else { return UITableViewCell() }
        let notification = notificationArray[indexPath.row]
        guard let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else { return UITableViewCell() }
        notificationCell.notification = notification
        notificationCell.removeAction = { [weak self] selectedCell in
            guard let `self` = self else { return }
            if let indexPath = tableView.indexPath(for: selectedCell) {
                self.removeNotification(index: indexPath.row)
            }
        }
        if let read = notification.read, read == "0", let key = notification.key, let userId = userData?.firebase_user_key {
            refNotifications.child(userId).child(key).child("read").setValue("1")
        }
        notificationCell.selectionStyle = .none
        return notificationCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == tableView.numberOfRows(inSection: 0) - 1 else { return }
        if !hasFetchedAll && !isFetching {
          //  fetchNotifications()
        }
    }
}
