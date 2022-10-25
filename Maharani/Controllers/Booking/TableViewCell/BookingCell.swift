//
//  BookingCell.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit

class BookingCell: UITableViewCell {
   
    var bookingItem : Booking? {
        didSet{
            serviceName.text = bookingItem?.service_name ?? ""
            orderId.text = bookingItem?.order_no ?? ""
            bookingTime.text =  (bookingItem?.ordertime_slot ?? "").changeTimeToFormatWithoutGlobal(frmFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd MMM yyyy : hh.mm a")
            noOfPerson.setTitle(bookingItem?.total_quantity, for: .normal)
            let finalTotal = (Double(bookingItem?.grand_total ?? "0") ?? 0.0) + (Double(bookingItem?.transport_amount ?? "0") ?? 0.0)
            price.text = "AED \(finalTotal)"
        }
    }
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var bookingTime: UILabel!
    @IBOutlet weak var noOfPerson: UIButton!
    @IBOutlet weak var price: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
