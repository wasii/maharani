//
//  ServicesDetailCell.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit
import SDWebImage
class ServicesDetailCell: UITableViewCell {
    
    var subCat : Services? {
        didSet {
            var myInt = ((subCat?.product_total ?? "") as NSString).integerValue
            var qty = ((subCat?.purchase_qty ?? "") as NSString).integerValue
            serviceName.text = "\(subCat?.service_name ?? "") (\(subCat?.purchase_qty ?? ""))"
            price.text = "AED \(myInt/qty)"
            var string = (subCat?.service_description ?? "").htmlToString
            serviesDetail.text = string
            if let userImg = subCat?.service_image, userImg.trimmingCharacters(in: .whitespaces) != "" {
                serviceImg.sd_setImage(with: URL(string: subCat?.service_image ?? ""), placeholderImage: UIImage(named: "hair"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                })
                
            } else {
            }
        }
    }
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var serviceImg: UIImageView!
    @IBOutlet weak var serviesDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
