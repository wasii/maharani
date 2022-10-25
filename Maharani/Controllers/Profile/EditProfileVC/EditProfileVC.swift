//
//  EditProfileVC.swift
//  Maharani
//
//  Created by Zain on 13/01/2022.
//

import UIKit
import Alamofire

class EditProfileVC: BaseViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var codelbl: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    var imagePicker: ImagePicker!
    
    var countries: [CountryData]? {
        didSet {
            guard let countries = countries else { return }
            for country in countries {
                guard let dialcode = country.dial_code else { continue }
                if dialcode == "971" {
                   // selectedCountryCodeData = country
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
        populateData()
        
    }
    func setInterface(){
        type = .cart
        viewControllerTitle = "Edit Profile"
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    func populateData() {
        userImage.sd_setImage(with: URL(string: SessionManager.getUserData()?.user_image ?? ""), placeholderImage: #imageLiteral(resourceName: "account-circle-large"))
        nameTxt.text = SessionManager.getUserData()?.user_full_name ?? ""
        emailTxt.text = SessionManager.getUserData()?.user_email ?? ""
        if((SessionManager.getUserData()?.dial_code ?? "") != ""){
        codelbl.text = "+\(SessionManager.getUserData()?.dial_code ?? "")"
        }
        mobileTxt.text = SessionManager.getUserData()?.phone_number ?? ""
        
        
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
    
    //MARK: - Actions
    @IBAction func editImageAction(_ sender: Any) {
        self.imagePicker.present(from: self.view)
    }
    @IBAction func countryCodeAction(_ sender: Any) {
        presentListView(dataModel: countries, isShowSearch: false, titleString: "Select dial code",isForDialCode: true)
    }
    
    func isValidForm() -> Bool {
        if nameTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Please enter full name")
            return false
        } else  if emailTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add Email")
            return false
        } else if !(emailTxt.text?.isValidEmail() ?? false) {
            Utilities.showWarningAlert(message: "Please enter valid E-Mail")
            return false
        } else if mobileTxt.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Enter Mobile number")
            return false
        }
        return true
    }
    
    @IBAction func uploadBtnAction(_ sender: Any) {
        if isValidForm() {
            let parameters:[String:String] = [
                "access_token" : SessionManager.getUserData()?.accessToken ?? "",
                "user_name" : nameTxt.text ?? "",
                "user_dial_code" : "971",
                "user_email" : emailTxt.text ?? "",
                "user_phone" : mobileTxt.text ?? "",
                "user_country" : "4",
                "language" : "1",
                
            ]
            
            let userFile:[String:[UIImage?]] = ["user_image" :[self.userImage.image]]
            
            AccountAPIManager.updateUserProfileAPI(images:userFile, parameters: parameters) { response in
                 switch response.status {
                 case "1" :
                     Utilities.showSuccessAlert(message: response.message ?? "") {
                         if(response.oTPVerify == "1"){
                             var str = "\(self.codelbl.text ?? "")\(self.mobileTxt.text ?? "")"
                             Switcher.gotoOTP(delegate: self, token: SessionManager.getUserData()?.accessToken ??  "", phone: str)
                             UserDefaults.standard.set(nil, forKey: "googleImage")
                         }else {
                             
                             self.navigationController?.popViewController(animated: true)
                             UserDefaults.standard.set(nil, forKey: "googleImage")
                         }
                        
                     }
                 default :
                     Utilities.showWarningAlert(message: response.message ?? "")
                 }
             }
        }
           
    }
}
extension EditProfileVC : ListSelectionProtocol {
    func dataSelectedWith(data: Any?, isForCountryCode: Bool) {
        if let countryData = data as? CountryData {
            selectedCountryCodeData = countryData
        }
    }
}
extension EditProfileVC:ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String, fileSize: String) {
        if(image != nil){
        self.userImage.image = image
        }
    }
    
}

extension EditProfileVC:UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 10
    }
}
