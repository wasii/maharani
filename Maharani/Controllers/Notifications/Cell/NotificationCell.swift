//
//  NotificationCell.swift
//  Opium
//
//  Created by Zain on 16/12/2021.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    var removeAction: ((NotificationCell)->())?
    
    var notification: NotificationModel? {
        didSet {
            titleLbl.text = notification?.title ?? ""
            descriptionLbl.text = notification?.description ?? ""
            if let date = notification?.createdAt {
                datelbl.text = date.changeTimeToFormat(frmFormat: "dd-MM-yyyy HH:mm:ss", toFormat: "dd MMM,yyyy")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeButtonAction(_ sender: Any) {
          removeAction?(self)
      }
}
