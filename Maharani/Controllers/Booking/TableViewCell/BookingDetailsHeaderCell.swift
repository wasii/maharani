//
//  BookingDetailsHeaderCell.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit

class BookingDetailsHeaderCell: UITableViewCell {

    @IBOutlet weak var numberOfServicelbl: UILabel!
    var bookingItem : Booking? {
        didSet{
            serviceName.text = bookingItem?.service_name ?? ""
            orderId.text = bookingItem?.order_no ?? ""
            bookingTime.text = (bookingItem?.ordertime_slot ?? "").changeTimeToFormatWithoutGlobal(frmFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy : hh.mm a")
            noOfPerson.setTitle(bookingItem?.total_quantity, for: .normal)
            status.text = "\(bookingItem?.order_status_label ?? "")"
            
        }
    }
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var bookingTime: UILabel!
    @IBOutlet weak var noOfPerson: UIButton!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberOfServicelbl.text = "Number of Service"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
