//
//  BookingServicesCell.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit

class BookingServicesCell: UITableViewCell {
    @IBOutlet weak var tableView: IntrinsicallySizedTableView!
    @IBOutlet weak var lblServices: UILabel!
    var serviceCategories: [Services]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Populate Data
    func populateServiceDetailsWith(booking :[Services]?) {
        serviceCategories = booking
        lblServices.text = "\(serviceCategories?.count ?? 0) SERVICES"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
extension BookingServicesCell:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension BookingServicesCell:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceCategories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesDetailCell") as! ServicesDetailCell
        cell.subCat = serviceCategories?[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
        
        
    }
}
