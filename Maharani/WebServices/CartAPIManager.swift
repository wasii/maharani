//
//  AuthenticationAPIManager.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation
import Alamofire

class CartAPIManager {
    
    //// Add to cart services
    struct AddCartDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/add_service_to_cart"
    }
    public class func AddCartDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: Cart_Base) -> Void) {
        
        var config = AddCartDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Cart_Base.self, from: json)
                cartCount = "\(response.oData?.cart_services?.count ?? 0)"
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////SubCategories APi
    struct SubCategoriesDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/home/get_service_list_by_categry"
    }
    public class func GetSubCategoriesDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: Services_Base) -> Void) {
        
        var config = SubCategoriesDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Services_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////Get Cart APi
    struct GetCartDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/get_cart"
    }
    public class func getUserCartDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: Cart_Base) -> Void) {
        
        var config = GetCartDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Cart_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////Delte Cart APi
    struct DeleteCartDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "/webservices/cart/delete_product"
    }
    public class func DeleteUserCartDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        
        var config = DeleteCartDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(MAGeneralForAddressModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    ////Minus Quty
    struct UpdateCartDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/reduce_cart"
    }
    public class func UpdateUserCartDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralForAddressModel) -> Void) {
        
        var config = UpdateCartDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(MAGeneralForAddressModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    struct UpdateCartAddDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/reduce_cart"
    }
    public class func AddUserCartDataAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralModel) -> Void) {
        
        var config = UpdateCartAddDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(MAGeneralModel.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    ////Time slot APi
    struct TimeSlotDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/get_time_slote"
    }
    public class func getTimeSlotData(parameters: [String: String], completionHandler : @escaping(_ result: TimeSlot_Base) -> Void) {
        
        var config = TimeSlotDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(TimeSlot_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////Check out
    struct CheckoutDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/checkout"
    }
    public class func CheckOutData(parameters: [String: String], completionHandler : @escaping(_ result: Checkout_Base) -> Void) {
        
        var config = CheckoutDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Checkout_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    ////Place Order
    struct PlaceOrderDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/place_order"
    }
    public class func PlaceOrderAPi(parameters: [String: String], completionHandler : @escaping(_ result: PlaceOrder_Base) -> Void) {
        
        var config = PlaceOrderDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(PlaceOrder_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    ////Place Order
    struct ProcessPaymentDataConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/cart/process_payment"
    }
    public class func processPaymentAPi(parameters: [String: String], completionHandler : @escaping(_ result: InitPayment_Base) -> Void) {
        
        var config = ProcessPaymentDataConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(InitPayment_Base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
}
