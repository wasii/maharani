//
//  ListTableViewCell.swift
//  HireEmirati
//
//  Created by Albin Jose on 22/12/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var itemImageContainerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
