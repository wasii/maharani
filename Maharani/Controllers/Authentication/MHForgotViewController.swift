//
//  MHLoginViewController.swift
//  Maharani
//
//  Created by Zain on 07/01/2022.
//

import UIKit

class MHForgotViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - UI
    func  setInterface() {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK: - Methods
    func isValidForm() -> Bool {
        if emailTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter E-Mail")
            return false
        }
        if !(emailTxt.text?.isValidEmail() ?? false) {
            Utilities.showWarningAlert(message: "Please enter valid E-Mail")
            return false
        }
        return true
    }
    //MARK: - Actions
    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func ForgotButtonAction(_ sender: Any) {
        if isValidForm() {
           // guard let deviceId = SessionManager.getCartId() else { return }
            let parameters:[String:String] = [
                "user_email" : emailTxt.text ?? "",
                "type" : "1",
                "language" : "1"
            ]
            AuthenticationAPIManager.forgotPasswordAPI(parameters: parameters) { result in
                switch result.status {
                case "1" :
                    Utilities.showSuccessAlert(message: result.message ?? "") {
                        self.navigationController?.popViewController(animated: true)
                    }
                default:
                    Utilities.showWarningAlert(message: result.message ?? "")
                }
            }
        }
    }
    
}
