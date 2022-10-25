//
//  ItemCollectionViewCell.swift
//  Derive
//
//  Created by Mac User on 26/05/21.
//  Copyright © 2021 Mac User. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    var baseVc : UIViewController?
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var baseView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: - Populate Data
    func populateServiceCategories(categories : Category?) {
        self.itemLabel.text = categories?.category_name ?? ""
        if let userImg = categories?.category_image, userImg.trimmingCharacters(in: .whitespaces) != "" {
            itemImage.sd_setImage(with: URL(string: categories?.category_image ?? ""), placeholderImage: UIImage(named: "hair"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            })
            
        } else {
        }
        itemImage.layer.cornerRadius = itemImage.frame.width/2
    }
    
}
