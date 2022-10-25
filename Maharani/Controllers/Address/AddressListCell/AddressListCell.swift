//
//  AddressListCell.swift
//  Maharani
//
//  Created by Zain on 14/01/2022.
//

import UIKit

protocol AddressListCellDelegate: AnyObject {
    func deleteAddress (selectedAddress:address?)
}

class AddressListCell: UITableViewCell {
    var parent = UIViewController()
    weak var delegate : AddressListCellDelegate?
    @IBOutlet weak var addressType: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var defaultAddress: UILabel!
    var userAddress : address?  {
        didSet {
            if(userAddress?.address_type == "1"){
                addressType.text = "Office"
            }else {
                addressType.text = "Home"
            }
            if(userAddress?.default_address == "1"){
                defaultAddress.isHidden = false
            }else {
                defaultAddress.isHidden = true
            }
            var addressArray: [String] = []
            if let name = userAddress?.cutomer_name { addressArray.append(name) }
            if let area_name = userAddress?.location { addressArray.append(area_name)}
            if let country_name = userAddress?.country_name { addressArray.append(country_name) }
            if let state_name = userAddress?.city_name { addressArray.append(state_name)}
            if let city_name = userAddress?.area_name { addressArray.append(city_name) }
            if let buildingName = userAddress?.building_name { if buildingName != "" { addressArray.append(buildingName) }}
            if let street = userAddress?.street_name {if street != ""{ addressArray.append(street) }}
            address.text =  addressArray.joined(separator: ", ")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnEditAddress(_ sender: Any) {
        Switcher.goToEditAddress(delegate: parent, isEdit: true, selectedAddress : userAddress! )
    }
    @IBAction func btnDeleteAddress(_ sender: Any) {
        Utilities.showQuestionAlert(message: "Are you sure you want to delete address?") {
            self.delegate?.deleteAddress(selectedAddress: self.userAddress)
        }
        
    }
}
