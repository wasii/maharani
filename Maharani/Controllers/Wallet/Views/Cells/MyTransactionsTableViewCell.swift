//
//  MyTransactionsTableViewCell.swift
//  Maharani
//
//  Created by Albin Jose on 20/01/22.
//

import UIKit

class MyTransactionsTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionIdLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Populate Data
    func configureCellWith(transactionData:List_data?) {
        transactionIdLbl.text = "Transaction ID: " + (transactionData?.transaction_id ?? "")
        dateLbl.text = transactionData?.created_date_time
        amountLbl.text = "AED " + (transactionData?.amount ?? "")
        switch transactionData?.amount_type {
        case "+":
            amountLbl.textColor = .systemGreen
        case "-":
            amountLbl.textColor = .red
        default:
            break
        }
    }

}
