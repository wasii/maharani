//
//  ServicesDescVC.swift
//  Maharani
//
//  Created by Zain on 20/01/2022.
//

import UIKit
import SDWebImage
class ServicesDescVC: BaseViewController {
    var selectedService : Services?
    @IBOutlet weak var servicesImage: UIImageView!
    @IBOutlet weak var servicesName: UILabel!
    @IBOutlet weak var servicesDes: UILabel!
    @IBOutlet weak var servicesPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Service Detail"
        populateData()
    }
    func populateData(){
        self.servicesName.text =  selectedService?.service_name ?? ""
        self.servicesDes.text = (selectedService?.service_description ?? "").html2String
        self.servicesPrice.text = "AED \(selectedService?.service_price ?? "")"
        if let userImg = selectedService?.service_image, userImg.trimmingCharacters(in: .whitespaces) != "" {
            servicesImage.sd_setImage(with: URL(string: selectedService?.service_image ?? ""), placeholderImage: UIImage(named: "hair"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            })
            
        } else {
        }
    }

    @IBAction func BtnAddtoCart(_ sender: Any) {
        AddToCart()
    }
    //MARK: - Methodes
    func AddToCart() {
        let parameters:[String:String] = [
            "access_token" : SessionManager.getUserData()?.accessToken ?? "",
            "language" : "1","device_cart_id" : SessionManager.getCartId() ?? "" , "service_id" : selectedService?.service_id ?? "","quantity" : "1" , "currency_code" : "AED" , "quantity_update" : "1"]
        CartAPIManager.AddCartDataAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                
                let frame = CGRect(x:  (self?.view.frame.origin.x)!, y: (self?.view.frame.origin.y)!, width: self!.servicesImage.frame.size.width, height: self!.servicesImage.frame.size.height)
                Utilities.addToCartAnimation(vc:  self, frame: frame, image: self!.servicesImage.image)
                
               
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }

}
