//
//  MHRegisterViewController.swift
//  Maharani
//
//  Created by Zain on 08/01/2022.
//

import UIKit

class MHRegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var codelbl: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var pwdTxt: UITextField!
    @IBOutlet weak var confirmPwdTxt: UITextField!
    
    var countries: [CountryData]? {
        didSet {
            guard let countries = countries else { return }
            for country in countries {
                guard let dialcode = country.dial_code else { continue }
                if dialcode == "971" {
                    selectedCountryCodeData = country
                }
            }
        }
    }
    var selectedCountryCodeData: CountryData? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                codelbl.text = "+" + (selectedCountryCodeData?.dial_code ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        fetchCountries()
        // Do any additional setup after loading the view.
    }

    func presentListView(dataModel : [Any]?,isShowSearch:Bool,titleString : String,isForDialCode:Bool = false) {
        guard let listVC = UIStoryboard.init(name: Storyboards.List, bundle: nil).instantiateViewController(withIdentifier: "MAListViewController") as? MAListViewController else { return  }
        listVC.dataModel = dataModel
        listVC.doShowSearch = isShowSearch
        listVC.pageTitle = titleString
        listVC.isForDialCode = isForDialCode
        listVC.delegate = self
        let navVC = UINavigationController.init(rootViewController: listVC)
        navVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    //MARK: - UI
    func  setInterface() {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK: - Methods
    func isValidForm() -> Bool {
        if nameTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter first name")
            return false
        }
        if emailTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter E-Mail")
            return false
        }
        if !(emailTxt.text?.isValidEmail() ?? false) {
            Utilities.showWarningAlert(message: "Please enter valid E-Mail")
            return false
        }
        if pwdTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter password")
            return false
        }
        if confirmPwdTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please confirm password")
            return false
        }
        return true
    }
    //MARK: - Methods
    func fetchCountries() {
        MAListAPIManager.countryListAPI(parameters: [:]) { [weak self] response in
           switch response.status {
           case "1" :
            self?.countries = response.oData ?? []
           default :
            Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    @IBAction func viewPwdAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        pwdTxt.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func viewConfrimPwdAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmPwdTxt.isSecureTextEntry = !sender.isSelected
    }
    //MARK: - Actions
    @IBAction func countryCodeAction(_ sender: Any) {
        presentListView(dataModel: countries, isShowSearch: false, titleString: "Select dial code",isForDialCode: true)
    }
    @IBAction func registerButtonAction(_ sender: Any) {
        if isValidForm() {
            guard let deviceId = SessionManager.getCartId() else { return }
            let parameters:[String:String] = [
                "user_name" : nameTxt.text ?? "",
                "user_email" : emailTxt.text ?? "",
                "user_password" : pwdTxt.text ?? "",
                "user_country" : "4",
                "user_dial_code" : "971",
                "user_phone" : mobileTxt.text ?? "",
                "user_device_type" : deviceType,
                "user_device_token" : SessionManager.getFCMToken() ?? "",
                "device_cart_id" : deviceId,
                "language" : "1"
            ]
            AuthenticationAPIManager.RegisterAPI(parameters: parameters) { result in
                switch result.status {
                case "1" :
                   // Utilities.showSuccessAlert(message: result.message ?? "") {
                        if(result.oTPVerify == "1"){
                            
                            var Phone =  "+\(result.oData?.dial_code ?? "")" + "\(result.oData?.phone_number ?? "")"
                            //Switcher.gotoOTP(delegate: self ,token: result.accessToken ?? "" ,phone : Phone)
                            Switcher.gotoOTPFromRegister(delegate: self, token: result.accessToken ?? "", phone: Phone, email: self.emailTxt.text ?? "", password: self.pwdTxt.text ?? "")
                        }else {
                            self.navigationController?.popViewController(animated: true)
                        }
                  //  }
                default:
                    Utilities.showWarningAlert(message: result.message ?? "")
                }
            }
        }
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MHRegisterViewController : ListSelectionProtocol {
    func dataSelectedWith(data: Any?, isForCountryCode: Bool) {
        if let countryData = data as? CountryData {
            selectedCountryCodeData = countryData
        }
    }
}

extension MHRegisterViewController:UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 10
    }
}
