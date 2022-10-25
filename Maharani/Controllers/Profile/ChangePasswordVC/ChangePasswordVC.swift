//
//  ChangePasswordVC.swift
//  Maharani
//
//  Created by Zain on 14/01/2022.
//

import UIKit

class ChangePasswordVC: BaseViewController {
    @IBOutlet weak var oldPwdTxt: UITextField!
    @IBOutlet weak var newPwdTxt: UITextField!
    @IBOutlet weak var confirmPwdTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        // Do any additional setup after loading the view.
    }
    func setInterface(){
        type = .back
        viewControllerTitle = "Change Password"
        
    }
    //MARK: - Methods
    func isFormValid() -> Bool {
        if oldPwdTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Enter old password")
            return false
        }
        if newPwdTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Enter new password")
            return false
        }
        if confirmPwdTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Enter confirm password")
            return false
        }
        if newPwdTxt.text != confirmPwdTxt.text {
            Utilities.showWarningAlert(message: "Password miss match")
            return false
        }
        return true
    }
    @IBAction func viewPwdBtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 1001:
            sender.isSelected = !sender.isSelected
            oldPwdTxt.isSecureTextEntry = !sender.isSelected
        case 1002:
            sender.isSelected = !sender.isSelected
            newPwdTxt.isSecureTextEntry = !sender.isSelected
        default:
            sender.isSelected = !sender.isSelected
            confirmPwdTxt.isSecureTextEntry = !sender.isSelected
        }
    }
    @IBAction func submitBtnAction(_ sender: Any) {
        if isFormValid() {
            let parameters:[String:String] = [
                "access_token": SessionManager.getUserData()?.accessToken ?? "",
                "user_old_password" : oldPwdTxt.text ?? "",
                "user_new_password" : newPwdTxt.text ?? "",
                "language" : "1"
            ]
            
            AccountAPIManager.changePasswordAPI(parameters: parameters) { response in
                switch response.status {
                case "1" :
                    Utilities.showSuccessAlert(message: response.message ?? "") {
                        self.dismiss(animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                default :
                    Utilities.showWarningAlert(message: response.message ?? "")
                }
            }
        }
    }
}
