//
//  CategoryPriceCell.swift
//  Maharani
//
//  Created by Zain on 11/01/2022.
//

import UIKit
import SDWebImage

class CategoryPriceCell: UITableViewCell {
    var baseVc :UIViewController?
    @IBOutlet weak var subCatImg: UIImageView!
    @IBOutlet weak var subCatDes: UILabel!
    @IBOutlet weak var subCatPrice: UILabel!
    @IBOutlet weak var subCatTitle: UILabel!
    
    let cartHearBeatAnimationGroup: CAAnimationGroup = {
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        
        
        let group = CAAnimationGroup()
        group.duration = 2.7
        group.repeatCount = 1
        group.animations = [pulse1]
        return group
        
    }()
    var subCat : Services? {
        didSet {
            subCatTitle.text = subCat?.service_name ?? ""
            subCatPrice.text = "AED \(subCat?.service_price ?? "")"
            var string = (subCat?.service_description ?? "").htmlToString
            string = string.replacingOccurrences(of: "Â", with: "")
            subCatDes.text =  string.trimmingCharacters(in: .whitespaces)
            if let userImg = subCat?.service_image, userImg.trimmingCharacters(in: .whitespaces) != "" {
                subCatImg.sd_setImage(with: URL(string: subCat?.service_image ?? ""), placeholderImage: UIImage(named: "hair"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                })
                
            } else {
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func BtnAddtoCart(_ sender: Any) {
        AddToCart()
    }
    //MARK: - Methodes
    func AddToCart() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","device_cart_id" : SessionManager.getCartId() ?? "" , "service_id" : subCat?.service_id ?? "","quantity" : "1" , "currency_code" : "AED" , "quantity_update" : "1"]
        CartAPIManager.AddCartDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                
                let frame = CGRect(x:  self!.frame.origin.x, y: self!.frame.origin.y, width: self!.subCatImg.frame.size.width, height: self!.subCatImg.frame.size.height)
                Utilities.addToCartAnimation(vc:  self!.baseVc, frame: frame, image: self!.subCatImg.image)
                
               
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
