//
//  MHOTPViewController.swift
//  Maharani
//
//  Created by Zain on 08/01/2022.
//

import UIKit
import DPOTPView

class MHOTPViewController: UIViewController {
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var lblMobile: UILabel!
    var token = ""
    var phone = ""
    var email = ""
    var password = ""
    var isRegister = false
    override func viewDidLoad() {
        super.viewDidLoad()
        otpView.becomeFirstResponder()
        //  lblMobile.text = "+\(SessionManager.getUserData()?.dial_code ?? "")" + "\(SessionManager.getUserData()?.phone_number ?? "")"
        lblMobile.text = phone
        setInterface()
        
    }
    //MARK: - UI
    func  setInterface() {
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func closeBtnAction(_ sender: Any) {
        if(isRegister){
            Utilities.showQuestionAlert(message: "Unless you complete OTP verification, your account will not avaliable") {
                Switcher.gotoTabbar()
            }
        }else {
            Utilities.showQuestionAlert(message: "Unless you complete OTP verification, your phone number will not be changed") {
                Switcher.gotoTabbar()
            }
        }
        
    }
    @IBAction func verifyBtnAction(_ sender: Any) {
        OTPApi()
    }
    @IBAction func resendBtnAction(_ sender: Any) {
        ResendOTP()
    }
    //MARK: - Actions
    func OTPApi () {
        if otpView.validate() {
            
            let parameters:[String:String] = [
                "access_token" : token,
                "otp" : otpView.text ?? "",
                "language" : "1",
            ]
            AuthenticationAPIManager.OTPAPI( parameters: parameters) { response in
                switch response.status {
                case "1" :
                    
                    Utilities.showSuccessAlert(message: response.message ?? "") {
                        if(self.isRegister){
                            self.LoginAPi()
                        }else {
                            Switcher.gotoTabbar()
                        }
                    }
                    
                default :
                    Utilities.showWarningAlert(message: response.message ?? "")
                }
            }
        }
    }
    func LoginAPi() {
        guard let deviceId = SessionManager.getCartId() else { return }
        let parameters:[String:String] = [
            "user_email" : email,
            "user_password" : password,
            "user_device_token" : SessionManager.getFCMToken() ?? "",
            "user_device_type" : deviceType,
            "device_cart_id" : deviceId,
            "language" : "1"
        ]
        AuthenticationAPIManager.loginAPI(parameters: parameters) { result in
            switch result.status {
            case "1" :
                //  Utilities.showSuccessAlert(message: result.message ?? "") {
                Switcher.gotoTabbar()
                // }
            default:
                Utilities.showWarningAlert(message: result.message ?? "")
            }
        }
    }
    
    func ResendOTP () {
        let parameters:[String:String] = [
            "access_token" : token,
            "language" : "1",
        ]
        AuthenticationAPIManager.resendOTPAPI( parameters: parameters) { response in
            switch response.status {
            case "1" :
                Utilities.showSuccessAlert(message: "\(response.message ?? "") \(response.OTP ?? "")") {
                }
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
}
