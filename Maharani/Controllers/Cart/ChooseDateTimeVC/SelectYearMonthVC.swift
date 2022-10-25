//
//  SelectYearMonthVC.swift
//  Maharani
//
//  Created by Zain on 18/01/2022.
//

import UIKit
import AKMonthYearPickerView

protocol SelectYearMonthVCDelegate : AnyObject {
    func selectedDate(selected:String)
}
class SelectYearMonthVC: UIViewController {
    var selectedDate = ""
    weak var delegate : SelectYearMonthVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        AKMonthYearPickerView.sharedInstance.barTintColor =  #colorLiteral(red: 0.8, green: 0.6941176471, blue: 0.9803921569, alpha: 1)
        AKMonthYearPickerView.sharedInstance.show(vc: self, doneHandler: doneHandler, completetionalHandler: completetionalHandler)
    }
    private func doneHandler() {
        self.dismiss(animated: true) {
            
        }
        delegate?.selectedDate(selected: self.selectedDate)
        }
        
        private func completetionalHandler(month: Int, year: Int) {
            var string = "01"
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year,.month,.day], from: date)
            if(((components).year == year) && ((components).month == month)){
                if(components.day! < 9){
                string = "0\(components.day!)"
                }else {
                    string = "0\(components.day!)"
                }
            }
            
            if(month < 9){
                selectedDate = "\(year)-0\(month)-\(string)"
            }else {
                selectedDate = "\(year)-\(month)-\(string)"
            }
            
        }
    

}
