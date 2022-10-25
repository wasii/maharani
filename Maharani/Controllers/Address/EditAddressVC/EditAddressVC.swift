//
//  EditAddressVC.swift
//  Maharani
//
//  Created by Zain on 14/01/2022.
//

import UIKit
import CoreLocation

class EditAddressVC: BaseViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var homeSelectionImg: UIImageView!
    @IBOutlet weak var workAddressImg: UIImageView!
    @IBOutlet weak var defaultAddressSwitch: UISwitch!
    @IBOutlet weak var btnAdd: UIButton!
    
    var address:address?
    var addressType = "0"
    var setAsDefault = "0"
    var isEdit = false
    var selectedLattitude:String?
    var selectedLongitude:String?
    
    var countries: [CountryData]? {
        didSet {
            guard let countries = countries else { return }
            for country in countries {
                if let index = countries.firstIndex(where: { $0.dial_code == "971"}) {
                    selectedCountryCodeData = countries[index]
                    selectedCountryName = countries[index]
                    
                }
            }
        }
    }
    
    var cities: [CityData]? {
        didSet {
            if(isEdit) {
                if let index = cities?.firstIndex(where: { $0.city_name == (address?.city_name ?? "")}) {
                    selectedCityName = cities?[index]
                }
            }
        }
    }
    
    var areas: [AreaData]? {
        didSet {
            if(isEdit) {
                if let index = areas?.firstIndex(where: { $0.area_name_english == (address?.area_name ?? "")}) {
                   // selectedCityName = cities?[index]
                }
            }
        }
    }
    
    var selectedCountryCodeData: CountryData? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                codeLbl.text = "+" + (selectedCountryCodeData?.dial_code ?? "")
            }
        }
    }
    var selectedCountryName: CountryData? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                country.text = (selectedCountryName?.country_name ?? "")
                fetchCityData()
            }
        }
    }
    var selectedCityName: CityData? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                city.text = (selectedCityName?.city_name ?? "")
                fetchAreadData()
            }
        }
    }
    
    var selectedArea: AreaData? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                areaTextField.text = (selectedArea?.area_name_english ?? "")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    func setInterface(){
        type = .back
        if(isEdit){
        viewControllerTitle = "Edit Address"
            fetchCountries()
            populateData()
        }else {
        viewControllerTitle = "Add Address"
            self.firstName.text = SessionManager.getUserData()?.user_full_name ?? ""
            self.lastName.text = SessionManager.getUserData()?.user_last_name ?? ""
            if((SessionManager.getUserData()?.dial_code ?? "") != ""){
            self.codeLbl.text = "+\(SessionManager.getUserData()?.dial_code ?? "")"
            }
            self.mobile.text = "\(SessionManager.getUserData()?.phone_number ?? "")"
            fetchCountries()
        }
       
    }
    func presentListView(dataModel : [Any]?,isShowSearch:Bool,titleString : String,isForDialCode:Bool = false, isArea: Bool = false) {
        guard let listVC = UIStoryboard.init(name: Storyboards.List, bundle: nil).instantiateViewController(withIdentifier: "MAListViewController") as? MAListViewController else { return  }
        listVC.dataModel = dataModel
        listVC.doShowSearch = isShowSearch
        listVC.pageTitle = titleString
        listVC.isForDialCode = isForDialCode
        listVC.isForArea = isArea
        listVC.delegate = self
        let navVC = UINavigationController.init(rootViewController: listVC)
        navVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
    /// populate data
    func populateData() {
        guard let address = address else {
            return
        }
        self.btnAdd.setTitle("Edit Address", for: .normal)
        firstName.text = address.first_name ?? ""
        lastName.text = address.last_name ?? ""
       if((address.dial_code ?? "") != ""){
        codeLbl.text = "+\(address.dial_code ?? "")"
        }
        mobile.text = address.phone_no ?? ""
        city.text = address.city_name ?? ""
        country.text = address.country_name ?? ""
        street.text = address.street_name ?? ""
        location.text = address.location ?? ""
        self.address1.text = address.flat_no ?? ""
        self.address2.text = address.building_name ?? ""
        self.areaTextField.text = address.area_name ?? ""
        selectedLattitude = address.latitude
        selectedLongitude = address.longitude
        switch address.default_address {
        case "1":
            setAsDefault = "1"
            defaultAddressSwitch.isOn = true
        default:
            setAsDefault = "0"
            defaultAddressSwitch.isOn = false
        }
        switch address.address_type {
        case "0":
            homeSelectionImg.image = UIImage(named: "select")
            workAddressImg.image = UIImage(named: "unselect")
        default:
            homeSelectionImg.image = UIImage(named: "unselect")
            workAddressImg.image = UIImage(named: "select")
        }
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
    
    
    //MARK: - Methodes
    func fetchCityData() {
        let parameters:[String:String] = [
            "country_id" : selectedCountryName?.country_id ?? "",
            "language" : "1"]
        MAListAPIManager.cityListAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.cities = response.oData
                
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
    //MARK: - Area data
    func fetchAreadData() {
        let parameters:[String:String] = [
            "city_id" : self.selectedCityName?.city_id ?? "11",
            "language" : "1", "access_token" : SessionManager.getUserData()?.accessToken ?? ""]
        MAListAPIManager.areaListAPI(parameters: parameters) { [weak self] response in
            switch response.status {
            case "1" :
                self?.areas = response.oData
            default:
                Utilities.showWarningAlert(message: response.message ?? "")
            }
        }
    }
    
    /// validate form
    func isContentsValid() -> Bool {
        if firstName.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add first name")
            return false
        } else if lastName.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add last name")
            return false
        }  else if mobile.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add mobile number")
            return false
        } else if mobile.text?.count ?? 0 < 5 || (mobile.text?.count ?? 0) > 12 {
            Utilities.showWarningAlert(message: "Contact Number is not valid")
            return false
        } else if city.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add city")
            return false
        } else if location.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add street address")
            return false
        } else if areaTextField.text?.trimmingCharacters(in: .whitespaces) == "" {
            Utilities.showWarningAlert(message: "Add Area")
            return false
        }
        return true
    }
    
    //MARK: - Actions
    @IBAction func countryCodeAction(_ sender: Any) {
        presentListView(dataModel: countries, isShowSearch: false, titleString: "Select dial code",isForDialCode: true)
    }
    //MARK: - Actions
    @IBAction func countrynameAction(_ sender: Any) {
        presentListView(dataModel: countries, isShowSearch: false, titleString: "Select Country",isForDialCode: false)
    }
    @IBAction func citynameAction(_ sender: Any) {
        presentListView(dataModel: cities, isShowSearch: false, titleString: "Select City",isForDialCode: false)
    }
    @IBAction func areanameAction(_ sender: Any) {
        presentListView(dataModel: areas, isShowSearch: false, titleString: "Select Area",isArea: true)
    }
    @IBAction func addressTypeSelection(_ sender: UIButton) {
        switch sender.tag {
        case 1001:
            homeSelectionImg.image = UIImage(named: "select")
            workAddressImg.image = UIImage(named: "unselect")
            addressType = "0"
        default:
            homeSelectionImg.image = UIImage(named: "unselect")
            workAddressImg.image = UIImage(named: "select")
            addressType = "1"
        }
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true :
            setAsDefault = "1"
        default:
            setAsDefault = "0"
        }
    }
    @IBAction func locationBtnAction(_ sender: Any) {
        Utilities.presentPlacePicker(vc: self)
    }
    @IBAction func saveAddressAction(_ sender: Any) {
        if(isContentsValid()){
            var parameters :[String:String] = [
                "access_token":SessionManager.getUserData()?.accessToken ?? "",
                "first_name":firstName.text ?? "",
                "last_name":lastName.text ?? "",
                "flat_no":self.address1.text ?? "",
                "building_name":self.address2.text ?? "",
                "street_name":street.text ?? "",
                "location":location.text ?? "",
                "city":selectedCityName?.city_id ?? "",
                "country_id":selectedCountryName?.country_id ?? "",
                "dial_code":"971",
                "user_phone":mobile.text ?? "",
                "language":"1",
                "default_address":self.setAsDefault,
                "address_type":self.addressType,
                "latitude" : selectedLattitude ?? "",
                "longitude" : selectedLongitude ?? "",
                "area_id": selectedArea?.area_id ?? ""
            ]
            if(isEdit) {
                parameters["address_id"] = address?.shiping_details_id ?? ""
                if let _ = selectedArea {
                    parameters["area_id"] = selectedArea?.area_id ?? ""
                } else {
                    parameters["area_id"] = address?.area_id ?? ""
                }
                if let _ = selectedCityName {
                    parameters["city"] = selectedCityName?.city_id ?? ""
                } else {
                    parameters["city"] = address?.city_id ?? ""
                }
                AddressAPIManager.EditAddressApi(parameters: parameters) { [weak self] response in
                    switch response.status {
                    case "1" :
                        Utilities.showSuccessAlert(message: response.message ?? "", okayHandler: {
                            self?.navigationController?.popViewController(animated: true)
                        })
                    default :
                        Utilities.showWarningAlert(message: response.message ?? "")
                    }
                }
            }else {
                AddressAPIManager.SaveAddressApi(parameters: parameters) { [ weak self] response in
                    switch response.status {
                    case "1" :
                        Utilities.showSuccessAlert(message: response.message ?? "", okayHandler: {
                            self?.navigationController?.popViewController(animated: true)
                        })
                    default :
                        Utilities.showWarningAlert(message: response.message ?? "")
                    }
                }
            }
        }
    }
}
extension EditAddressVC : ListSelectionProtocol {
    func dataSelectedWith(data: Any?, isForCountryCode: Bool) {
        if(isForCountryCode == true){
            if let countryData = data as? CountryData {
                selectedCountryCodeData = countryData
            }
        }else {
            if let countryData = data as? CountryData {
                selectedCountryName = countryData
            }
            if let cityData = data as? CityData {
                selectedCityName = cityData
            }
            if let areaData = data as? AreaData {
                selectedArea = areaData
            }
        }
    }
}
extension EditAddressVC: PlacePickerDelegate {
    func placePicked(coordinate: CLLocationCoordinate2D, address: String) {
        location.text = address
        selectedLattitude = String(coordinate.latitude)
        selectedLongitude = String(coordinate.longitude)
    }
}
extension EditAddressVC:UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 10
    }
}
