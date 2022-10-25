//
//  dateTimeCell.swift
//  Maharani
//
//  Created by Zain on 12/01/2022.
//

import UIKit
import DatePickerDialog
protocol dateTimeHeaderCellDelegate : AnyObject {
    func ShowDatePickere()
}
class dateTimeHeaderCell: UITableViewCell {
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    weak var delegate : dateTimeHeaderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM, yyyy"
        let someDateTime = formatter.string(from: date as Date)
        lblToday.text = "Today : \(someDateTime)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func btnOpenPicker(_ sender: Any) {
        delegate?.ShowDatePickere()
    }
    func populateTop(time : String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: time)
        formatter.dateFormat = "MMMM-yyyy"
        self.lblYear.text = formatter.string(from: date!)
    }
}
