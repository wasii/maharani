//
//  CancelBookingCell.swift
//  Maharani
//
//  Created by Zain on 20/01/2022.
//

import UIKit

protocol CancelBookingCellDelegate : AnyObject {
    func refresh()
}
class CancelBookingCell: UITableViewCell {
    var parent : UIViewController?
    weak var delegate : CancelBookingCellDelegate?
    var bookingItem : Booking? {
        didSet{
        }
    }
    var order_id = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func cancelBooking(_ sender: UIButton) {
        DeleteBookingData()
    }
    func DeleteBookingData() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "order_id" : order_id, "order_line_id" : "" ]
        BookingAPIManager.DeleteUserBookingAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                Utilities.showWarningAlert(message: response.message ?? ""){
                    self?.delegate?.refresh()
                }
              
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
