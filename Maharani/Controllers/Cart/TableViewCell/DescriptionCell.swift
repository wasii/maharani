//
//  DescriptionCell.swift
//  Maharani
//
//  Created by Zain on 12/01/2022.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionTxt: TextViewWithPlaceholder!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
