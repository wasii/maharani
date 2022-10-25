//
//  cartCells.swift
//  Maharani
//
//  Created by Zain on 11/01/2022.
//

import UIKit
import SDWebImage

protocol cartCellsDelegate : AnyObject {
    func refresh()
}
class cartCells: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var service: UIImageView!
    @IBOutlet weak var btnQty: UIButton!
    weak var delegate : cartCellsDelegate?
    
    var itemCart : CartServices? {
        didSet{
            name.text = itemCart?.service_name ?? ""
            var string = (itemCart?.service_description ?? "").htmlToString
            des.text = string
            price.text = "AED \(itemCart?.sale_price ?? "")"
            btnQty.setTitle(itemCart?.cart_quantity ?? "", for: .normal)
            if let userImg = itemCart?.service_image, userImg.trimmingCharacters(in: .whitespaces) != "" {
                service.sd_setImage(with: URL(string: itemCart?.service_image ?? ""), placeholderImage: UIImage(named: "hair"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                })
                
            } else {
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnPlus(_ sender: Any) {
        var total = Int(self.btnQty.titleLabel?.text ?? "0")!
        total =  total + 1
        self.btnQty.setTitle(String(total), for:.normal)
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","device_cart_id" : SessionManager.getCartId() ?? "" , "service_id" : itemCart?.service_id ?? "","quantity" : "1" , "currency_code" : "AED" , "quantity_update" : String(total)]
        CartAPIManager.AddCartDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.delegate?.refresh()
              //  Utilities.showWarningAlert(message: response.message ?? "")
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    @IBAction func btnMinus(_ sender: Any) {
        var total = Int(self.btnQty.titleLabel?.text ?? "0")!
        total =  total - 1
        if(total > 0){
        self.btnQty.setTitle(String(total), for:.normal)
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token": SessionManager.getUserData()?.accessToken ?? "",
            "device_cart_id" : deviceId,
            "cart_id" : itemCart?.cart_id ?? "",
            "currency_code" : "AED",
            "quantity" : String(total),
            "language" : "1"
        ]
        
        CartAPIManager.UpdateUserCartDataAPI(parameters: parameters) { response in
            switch response.status {
            case "1" :
                self.delegate?.refresh()
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
        }
    }
    @IBAction func BtnRemove(_ sender: Any) {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "access_token": SessionManager.getUserData()?.accessToken ?? "",
            "device_cart_id" : deviceId,
            "cart_id" : itemCart?.cart_id ?? "",
            "currency_code" : "AED",
            "language" : "1"
        ]
        
        CartAPIManager.DeleteUserCartDataAPI(parameters: parameters) { response in
            switch response.status {
            case "1" :
                self.delegate?.refresh()
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
