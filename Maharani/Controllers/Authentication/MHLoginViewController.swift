//
//  MHLoginViewController.swift
//  Maharani
//
//  Created by Zain on 07/01/2022.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
class MHLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
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
        if passwordTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter password")
            return false
        }
        return true
    }
    //MARK: - Actions
    func loginWithSocialMedia(parameters : [String:String]) {
        AuthenticationAPIManager.socialLoginAPI(parameters: parameters) { response in
            switch response.status {
            case "1":
                Utilities.showSuccessAlert(message: "Login successful") {
                    Switcher.gotoTabbar()
                }
            default :
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        if isValidForm() {
            guard let deviceId = SessionManager.getCartId() else { return }
            let parameters:[String:String] = [
                "user_email" : emailTxt.text ?? "",
                "user_password" : passwordTxt.text ?? "",
                "user_device_token" : SessionManager.getFCMToken() ?? "",
                "user_device_type" : deviceType,
                "device_cart_id" : deviceId,
                "language" : "1"
            ]
            AuthenticationAPIManager.loginAPI(parameters: parameters) { result in
                switch result.status {
                case "1" :
                    Utilities.showSuccessAlert(message: result.message ?? "") {
                        Switcher.gotoTabbar()
                    }
                default:
                    Utilities.showWarningAlert(message: result.message ?? "")
                }
            }
        }
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        Switcher.gotoRegister(delegate: self)
    }
    @IBAction func viewPwdAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxt.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func forgotPwdAction(_ sender: Any) {
        Switcher.gotoForgot(delegate: self)
    }
    @IBAction func googleLoginAction(_ sender: Any) {
        guard let deviceId = SessionManager.getCartId() else { return }
        let signInConfig = GIDConfiguration.init(clientID: Config.googleSignInClientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            let userDict:[String:String] = [ "user_email":user?.profile?.email ?? "",
                                             "user_name":user?.profile?.name ?? "",
                                             "user_image":"",
                                             "user_device_token":SessionManager.getFCMToken() ?? "",
                                             "device_cart_id" :deviceId,
                                             "language": "1",
                                             "type" : "0",
                                             "user_device_type":"iOS"]
            
            if let imageUrl = user?.profile?.imageURL(withDimension: 100) {
                let userImage = imageUrl.absoluteString
                UserDefaults.standard.set(userImage, forKey: "googleImage")
                
            }
            self.loginWithSocialMedia(parameters: userDict)
            
        }
    }
    @IBAction func appleLoginAction(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            guard let deviceId = SessionManager.getCartId() else { return }
            let fullName = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
//            if let userName = UserDefaults.standard.string(forKey: "fullNameApple"),let userEmail = UserDefaults.standard.string(forKey: "emailApple") {
                let userDict:[String:String] = [ "user_email":email ?? "test@gmail.com",
                                                 "user_name":fullName ?? "test",
                                                 "user_image":"",
                                                 "user_device_token":SessionManager.getFCMToken() ?? "",
                                                 "device_cart_id" :deviceId,
                                                 "language": "1",
                                                 "type" : "0",
                                                 "user_device_type":"iOS"]
                self.loginWithSocialMedia(parameters: userDict)
          //  }
            
        }
    }
    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        Switcher.gotoTabbar()
    }
}

extension MHLoginViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    }
}
