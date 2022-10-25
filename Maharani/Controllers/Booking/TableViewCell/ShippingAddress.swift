//
//  ShippingAddress.swift
//  Maharani
//
//  Created by Zain on 17/01/2022.
//

import UIKit
import SDWebImage
import Lightbox
protocol imagePresenterProtocol:AnyObject {
    func presentImages(images:[LightboxImage])
}
class ShippingAddress: UITableViewCell {
    @IBOutlet weak var address: UILabel!
   
    @IBOutlet weak var nationalitylabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var storeIdLabel: UILabel!
    @IBOutlet weak var staffDetailContainerView: UIView!
    
    var staffDetailData: BookingStaffDetail?
    var parent:UIViewController?
    weak var delegate:imagePresenterProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    //MARK: - Populate Data
    func populateServiceDetailsWith(booking :shippingaddress?, staffDetail: BookingStaffDetail?) {
        var addressString = "\(booking?.first_name ?? "") \(booking?.last_name ?? ""),\n+\(booking?.user_shiping_details_dial_code ?? "")\(booking?.user_shiping_details_phone ?? ""),\n\(booking?.user_shiping_details_loc ?? ""),\n\(booking?.country_name ?? ""),\n\(booking?.city_name ?? ""),\n\(booking?.area_name ?? "")"
        if booking?.user_shiping_details_building != "" {
            addressString += "\n\(booking?.user_shiping_details_building ?? "")"
        }
        if booking?.user_shiping_details_street != "" {
            addressString += "\n\(booking?.user_shiping_details_street ?? "")"
        }
        address.text = addressString
        
        
        self.profileImageView.sd_setImage(with: URL(string: staffDetail?.staff_profile_image ?? ""), placeholderImage: nil, options: .scaleDownLargeImages, completed: nil)
        self.idImageView.sd_setImage(with: URL(string: staffDetail?.staff_idcard_image ?? ""), placeholderImage: nil, options: .scaleDownLargeImages, progress: nil, completed: nil)
        self.nameLabel.text = "Name: \((staffDetail?.staff_first_name ?? "") + " " + (staffDetail?.staff_last_name ?? ""))"
        self.nationalitylabel.text = "Nationality: \(staffDetail?.staff_nationality ?? "")"
        self.storeIdLabel.text = "Store Id: \(staffDetail?.staff_store_id ?? "")"
        self.phoneLabel.text = "Contact: \(staffDetail?.staff_contact_number ?? "")"
        self.emailLabel.text = "Email: \(staffDetail?.staff_email_id ?? "")"
        
        self.staffDetailContainerView.isHidden = (staffDetail?.staff_first_name ?? "").count == 0
        staffDetailData = staffDetail
    }
    @IBAction func imageButtonActions(_ sender: UIButton) {
        switch sender.tag {
        case 1001:
            let images = [
                LightboxImage(imageURL: URL(string: staffDetailData?.staff_profile_image ?? "")!)
            ]
            delegate?.presentImages(images: images)
        default:
            let images = [
                LightboxImage(imageURL: URL(string: staffDetailData?.staff_idcard_image ?? "")!)
            ]
            delegate?.presentImages(images: images)
        }
    }
}
