//
//  MHCartVC.swift
//  Maharani
//
//  Created by Zain on 10/01/2022.
//

import UIKit
import AKMonthYearPickerView
import Stripe

class ChooseDateTimeVC: BaseViewController {
    var cart : Cart?
    var isMonthAction = false
    @IBAction func continueBtn(_ sender: Any) {
        if !SessionManager.isLoggedIn() {
            Switcher.presentLogin(viewController: self)
        }else {
            if(selectedTimeSlot != -1){
                var userDescription = ""
                if let cell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? DescriptionCell {
                    userDescription = cell.descriptionTxt.text
                }
                Switcher.goToCheckout(delegate: self,cart: self.cart,timeSlot: "\(self.selectedDate) \(timeSlots?[selectedTimeSlot].time_slot ?? "")",description: userDescription)
            }else {
                Utilities.showWarningAlert(message: "Please select avaliable time slot")
            }
        }
    }
    var timeSlots : [TimeSlots]? {
        didSet{
           tableView.reloadData()
        }
    }
    var selectedTimeSlot = -1
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var total: UILabel!
    var selectedDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .cart
        viewControllerTitle = "Choose Date - Time"
        total.text = "AED \(cart?.grand_total ?? "")"
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: date as Date)
        self.setuptable()
        self.fetchTimeSlotData()
        
        
    }
    func setuptable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func Open() {
        if isMonthAction {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.8) {
                self.isMonthAction = false
                let  sortVC = UIStoryboard(name: Storyboard.cart.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SelectYearMonthVC") as! SelectYearMonthVC
                sortVC.providesPresentationContextTransitionStyle = true
                sortVC.delegate = self
                sortVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                sortVC.modalPresentationStyle = .overCurrentContext
                self.tabBarController?.present(sortVC, animated: true)
            }
        }
    }
      //MARK: - Methodes
    func fetchTimeSlotData() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            let parameters:[String:String] = [
                "access_token" : SessionManager.getUserData()?.accessToken ?? "",
                "language" : "1","date" :self.selectedDate]
            CartAPIManager.getTimeSlotData(parameters: parameters) { [weak self] response in
                switch response.status {
                case "1" :
                    self?.timeSlots = response.oData
                  
                default:
                    Utilities.showWarningAlert(message: response.message ?? "")
                }
            }
        }
    }
}
extension ChooseDateTimeVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateTimeHeaderCell") as! dateTimeHeaderCell
            cell.populateTop(time: self.selectedDate)
            cell.delegate = self
            return cell
        }else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSlotCell") as! DateSlotCell
            cell.delegate = self
            cell.selectedDate = self.selectedDate
            cell.setInterface()
            return cell
        }else if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotCell") as! TimeSlotCell
            cell.layoutSubviews()
            cell.layoutIfNeeded()
            cell.delegate = self
            cell.baseVc = self
            cell.selectedDate = self.selectedDate
            cell.selectedTimeSlot = self.selectedTimeSlot
            cell.populateTimeSlots(time:timeSlots)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension ChooseDateTimeVC : dateTimeHeaderCellDelegate {
    func ShowDatePickere (){
        if isMonthAction {
            return
        }
        isMonthAction = true
        self.Open()
    }
}
extension ChooseDateTimeVC : TimeSlotCellDelegate {
    func selectedTime(slectedSlot: Int) {
        self.selectedTimeSlot = slectedSlot
        self.tableView.reloadData()
    }
}
extension ChooseDateTimeVC : DateSlotCellDelegate {
    func selectedDate(selectedDate: String) {
        self.selectedDate = selectedDate
        self.selectedTimeSlot = -1
        self.fetchTimeSlotData()
    }
}
extension ChooseDateTimeVC : SelectYearMonthVCDelegate {
    func selectedDate(selected:String) {
        if(selected != ""){
            self.selectedDate = selected
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date = formatter.date(from: self.selectedDate)
            self.selectedTimeSlot = -1
            self.fetchTimeSlotData()
        }
    }
    
   
}
