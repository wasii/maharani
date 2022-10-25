//
//  PaymentDetailsCell.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit

class PaymentDetailsCell: UITableViewCell {
    
    var bookingItem : Booking? {
        didSet{
            var discount = 0.0
            for item in bookingItem?.services ?? [] {
                
                discount = discount + Double(item.coupon_discount!)!
                
            }
            var totalDis = Double(bookingItem?.grand_total ?? "0")! - discount
            servicesFee.text = "AED \(bookingItem?.sub_total ?? "")"
            Discount.text = "AED \(discount)"
            transportLabel.text = "AED \(bookingItem?.transport_amount ?? "0.0")"
            totalDis += Double(bookingItem?.transport_amount ?? "0") ?? 0
            total.text = "AED \(totalDis)"
        }
    }
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var servicesFee: UILabel!
    @IBOutlet weak var Discount: UILabel!
    @IBOutlet weak var total: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
