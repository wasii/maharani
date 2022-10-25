//
//  HEListViewController.swift
//  HireEmirati
//
//  Created by Albin Jose on 22/12/21.
//

import UIKit

protocol ListSelectionProtocol: AnyObject {
    func dataSelectedWith(data:Any?,isForCountryCode : Bool)
}

class MAListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pageTitle = ""
    var dataModel:[Any]?
    var doShowSearch = false
    var isForDialCode = false
    var isForArea = false
    
    weak var delegate : ListSelectionProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerTitle = pageTitle
        type = .popups
    }

}

extension MAListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dataSelectedWith(data: dataModel?[indexPath.row], isForCountryCode: isForDialCode)
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension MAListViewController :UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as?  ListTableViewCell
        else {return UITableViewCell()}
        listCell.itemImageContainerView.isHidden = true
        listCell.codeLbl.isHidden = true
        if isForDialCode {
            listCell.codeLbl.isHidden = false
        }
        if let countryList = dataModel as? [CountryData] {
            listCell.titleLbl.text = countryList[indexPath.row].country_name
            listCell.codeLbl.text = "+" + (countryList[indexPath.row].dial_code ?? "")
        }
        if let city = dataModel as? [CityData] {
            listCell.titleLbl.text = city[indexPath.row].city_name
        }
        if let area = dataModel as? [AreaData] {
            listCell.titleLbl.text = area[indexPath.row].area_name_english
        }
        return listCell
    }
}


