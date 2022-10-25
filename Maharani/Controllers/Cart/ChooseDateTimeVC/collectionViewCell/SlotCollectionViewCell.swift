//
//  ItemCollectionViewCell.swift
//  Derive
//
//  Created by Mac User on 26/05/21.
//  Copyright © 2021 Mac User. All rights reserved.
//

import UIKit
import SDWebImage

class SlotCollectionViewCell: UICollectionViewCell {
    var baseVc : UIViewController?
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var baseView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
