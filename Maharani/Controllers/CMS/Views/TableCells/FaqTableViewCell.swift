//
//  FaqTableViewCell.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import UIKit

import UIKit

class FaqTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buttonFaqTitle: UIButton! {
        didSet {
            self.buttonFaqTitle?.titleLabel?.numberOfLines = 0
        }
    }
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var stackInnerShadow: UIStackView!
    @IBOutlet weak var faqArraow: UIImageView!
  
    
    var faqData : PrivacyData?{
        didSet {
            buttonFaqTitle.setTitle(faqData?.title, for: .normal)
            labelDetails.text = faqData?.description?.html2String
            if faqData?.expand == true {
                containerView.layer.maskedCorners = [.layerMaxXMinYCorner]
                viewDetails.isHidden = false
                faqArraow.image = UIImage(systemName: "arrowtriangle.down")
            } else {
                containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                viewDetails.isHidden = true
                faqArraow.image = UIImage(systemName: "arrowtriangle.up")

            }
        }
    }
    
    var faqExpandAction :((FaqTableViewCell)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    @IBAction func buttonActionFaqExpand(_ sender: UIButton) {
        faqExpandAction?(self)
    }
}
