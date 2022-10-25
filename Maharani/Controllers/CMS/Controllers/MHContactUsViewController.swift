//
//  MHContactUsViewController.swift
//  Maharani
//
//  Created by Albin Jose on 20/01/22.
//

import UIKit
import KMPlaceholderTextView
class MHContactUsViewController: BaseViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var messageTxtView: KMPlaceholderTextView!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Support"
    }
    func populateInitailData() {
        if SessionManager.isLoggedIn() {
            if let userData = SessionManager.getUserData() {
                nameTxt.text = userData.user_full_name
                emailTxt.text = userData.user_email
                mobileNumberTxt.text = userData.phone_number
            }
        }
    }
    //MARK: - Methods
    func isValidForm() -> Bool {
        if nameTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add Subject")
            return false
        }
        if emailTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add email")
            return false
        }
        if !(emailTxt.text?.isValidEmail() ?? false) {
            Utilities.showWarningAlert(message: "Add a valid email")
            return false
        }
        if mobileNumberTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add mobile")
            return false
        }
        if messageTxtView.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add message")
            return false
        }
        return true
    }
    func sendMessage() {
        if isValidForm() {
            let parameters:[String:String] = [
                "subject" : nameTxt.text ?? "",
                "email" : emailTxt.text ?? "",
                "user_message" : messageTxtView.text ?? "",
                "mobile" : mobileNumberTxt.text ?? "",
                "message" : messageTxtView.text ?? ""
            ]
            CMSAPIManager.contactUsAPI(parameters: parameters) { response in
                switch response.status {
                case "1" :
                    Utilities.showSuccessAlert(message: response.message ?? "") {
                        self.backButtonAction()
                    }
                default:
                    Utilities.showWarningAlert(message: response.message ?? "")
                }
            }
        }
    }
    @IBAction func submitBtnAction(_ sender: Any) {
        if isValidForm() {
            sendMessage()
        }
    }
}
