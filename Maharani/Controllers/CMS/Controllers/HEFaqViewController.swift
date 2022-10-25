//
//  HEFaqViewController.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import UIKit

class HEFaqViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var faqDataArray:[PrivacyData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "FAQ"
        fetchFaqData()
        // Do any additional setup after loading the view.
    }
    //MARK: - methods
    func fetchFaqData() {
        let parameters:[String:String] = [
            "language" : "1"
        ]
        CMSAPIManager.fetchFAQAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.faqDataArray = response.oData ?? []
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
extension HEFaqViewController:UITableViewDelegate{
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
extension HEFaqViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let faqCell = tableView.dequeueReusableCell(withIdentifier: "FaqTableViewCell", for: indexPath) as? FaqTableViewCell else { return UITableViewCell() }
        faqCell.selectionStyle = .none
        faqCell.faqData = faqDataArray[indexPath.row]
        faqCell.faqExpandAction = {[weak self] selectedCell in
            guard let `self` = self else { return  }
            guard let indexPathSelected = tableView.indexPath(for: selectedCell) else { return  }
            self.faqDataArray[indexPathSelected.row].expand =  (self.faqDataArray[indexPathSelected.row].expand ?? false) ? false:true
            DispatchQueue.main.async {
                //self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                self.tableView.reloadData()
            }
            
           // self.tableView.reloadRows(at: [indexPathSelected], with: .automatic)
        }
        return faqCell
    }
}

