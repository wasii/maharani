//
//  NotificationDetailsViewController.swift
//  Mitsumi
//
//  Created by Albin Jose on 06/11/21.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase
import SDWebImage
//import SKPhotoBrowser


class NotificationDetailsViewController: BaseViewController,UITextViewDelegate {
    
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    
    var userData: MHUser?
    var notificationId: String?
    var refNotifications: DatabaseReference!
    
    var notification: NotificationModel? {
        didSet {
            lblTitle.text = notification?.title ?? ""
            descriptionLabel.text = notification?.description ?? ""
            if let imageURL = notification?.imageURL, imageURL != "" {
                notificationImageView.isHidden = false
                notificationImageView.sd_setImage(with: URL(string: imageURL))
            }
            lblDate.text = (notification?.createdAt ?? "").changeTimeToFormat(frmFormat: "dd-MM-yyyy HH:mm:ss", toFormat: "dd-MM-yyyy,EEE hh:mm a")
            //  lblLink.text = notification?.description   ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Notification Details"
        userData = SessionManager.getUserData()
        notificationImageView.isHidden = true
        lblTitle.text = ""
        descriptionLabel.text = ""
        lblLink.text = ""
        refNotifications = Database.database().reference().child("Notifications")
        
        fetchNotificationData()
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
        fetchNotificationData()
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let url = URL(string: notification?.url ?? "") else { return }
        UIApplication.shared.open(url)
        
    }
    
    
    func fetchNotificationData() {
        guard let userId = userData?.firebase_user_key, userId != "" else { return }
        guard let notificationId = notificationId else { return }
        
        refNotifications.child(userId).child(notificationId).observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let `self` = self else { return }
            
            guard snapshot.exists(), let result = snapshot.value as? [String: Any] else {
                print("Child does not exist")
                return
            }
            do {
                let json = try JSONSerialization.data(withJSONObject: result)
                let notification = try JSONDecoder().decode(NotificationModel.self, from: json)
                notification.key = snapshot.key
                self.notification = notification
            } catch {
                
            }
        })
    }
}
