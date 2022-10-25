//
//  HECommonCMSPageViewController.swift
//  HireEmirati
//
//  Created by Albin Jose on 31/12/21.
//

import UIKit

enum CMSType {
    case about
    case terms
    case privacy
}
class HECommonCMSPageViewController: BaseViewController {

    @IBOutlet weak var detailsLbl: UILabel!
    var pageTitle = ""
    var cmsType:CMSType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = pageTitle
        fetchData()
    }
    //MARK: - fetchData
    func fetchData() {
        var cmsId = ""
        switch cmsType {
        case .about:
            cmsId = "ABOUT_US"
        case .privacy:
            cmsId = "PRIVACY_POLICY"
        default:
            cmsId = "TERMS_AND_CONDITION"
        }
        let parameters:[String:String] = [
            "uid" : cmsId,
            "language" : "1"
        ]
        
        CMSAPIManager.fetchCMSAPI(parameters: parameters) { response in
            switch response.status {
            case "1" :
                self.detailsLbl.text = response.oData?.html2String
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
