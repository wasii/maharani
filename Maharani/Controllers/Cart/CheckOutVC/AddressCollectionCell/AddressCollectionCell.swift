//
//  AddressCollectionCell.swift
//  Maharani
//
//  Created by Zain on 19/01/2022.
//

import UIKit

class AddressCollectionCell: UICollectionViewCell {
    var parent : UIViewController?
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var tickBtn: UIButton!
    var selectedId = ""
    var userAddress : address?  {
        didSet {
            if(userAddress?.address_type == "1"){
                lblType.text = "Office"
            }else {
                lblType.text = "Home"
            }
            if(selectedId == userAddress?.shiping_details_id){
                self.tickBtn.isHidden = false
            }else {
                self.tickBtn.isHidden = true
            }
            var addressArray: [String] = []
            if let name = userAddress?.cutomer_name { addressArray.append(name) }
            if let area_name = userAddress?.location { addressArray.append(area_name)}
            if let country_name = userAddress?.country_name { addressArray.append(country_name) }
            if let state_name = userAddress?.city_name { addressArray.append(state_name)}
            if let city_name = userAddress?.area_name { addressArray.append(city_name) }
            if let buildingName = userAddress?.building_name { if buildingName != "" { addressArray.append(buildingName) }}
            if let street = userAddress?.street_name {if street != ""{ addressArray.append(street) }}
            lblAddress.text =  addressArray.joined(separator: ", ")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func EditAddress(_ sender: Any) {
        Switcher.goToEditAddress(delegate: parent, isEdit: true, selectedAddress: userAddress!)
    }

}
