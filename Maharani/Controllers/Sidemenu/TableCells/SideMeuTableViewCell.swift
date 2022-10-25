//
//  SideMeuTableViewCell.swift
//  Opium
//
//  Created by Albin Jose on 13/12/21.
//

import UIKit

class SideMeuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitlelbl: UILabel!
    @IBOutlet weak var bottomSeparator: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
