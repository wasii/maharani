//
//  HEPrivacyPolicyViewController.swift
//  HireEmirati
//
//  Created by Albin Jose on 31/12/21.
//

import UIKit

class HEPrivacyPolicyViewController:  BaseViewController  {
    @IBOutlet weak var tableView: UITableView!
    
    var privacyDataArray:[PrivacyData]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Privacy Policy"
        fetchPrivacyData()
    }
    
    //MARK:- Methods
    func fetchPrivacyData() {
        let parameters:[String:String] = [
            "language" : "1"
        ]
        CMSAPIManager.fetchPrivacyAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.privacyDataArray = response.oData
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}

extension HEPrivacyPolicyViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension HEPrivacyPolicyViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyDataArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let privacyCell = tableView.dequeueReusableCell(withIdentifier: "PrivacyListTableViewCell", for: indexPath) as? PrivacyListTableViewCell else { return UITableViewCell() }
        privacyCell.titlelbl.text = privacyDataArray?[indexPath.row].title
        privacyCell.descriptionLbl.text = privacyDataArray?[indexPath.row].description?.html2String
        privacyCell.selectionStyle = .none
        return privacyCell
    }
}
