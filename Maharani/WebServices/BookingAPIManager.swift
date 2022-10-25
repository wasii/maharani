//
//  AccountAPIManager.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import Foundation
import Alamofire

class BookingAPIManager {
    
    /// fetch user Booking
    struct FetchBookingInfoConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/orders/get_booking_history"
    }
    class func fetchUserBookingAPI(parameters: [String: String], completionHandler : @escaping(_ result: Booking_base) -> Void) {
        var config = FetchBookingInfoConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                let response = try JSONDecoder().decode(Booking_base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    /// fetch  Booking Details
    struct FetchBookingDetailsInfoConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/orders/get_order_info"
    }
    class func fetchUserBookingDetailsAPI(parameters: [String: String], completionHandler : @escaping(_ result: BookingDetails_base) -> Void) {
        var config = FetchBookingDetailsInfoConfig()
        config.parameters = parameters
        APIClient.apiRequest(request: config) { (result) in
            do {
                let json = try JSONSerialization.data(withJSONObject: result as Any)
                print(result)
                let response = try JSONDecoder().decode(BookingDetails_base.self, from: json)
                completionHandler(response)
            } catch let err {
                print(err)
            }
        }
    }
    
    /// fetch  Booking Details
    struct DeleteBookingDetailsInfoConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .post
        var path = "webservices/user/booking_cancel"
    }
    class func DeleteUserBookingAPI(parameters: [String: String], completionHandler : @escaping(_ result: MAGeneralModel) -> Void) {
        var config = DeleteBookingDetailsInfoConfig()
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
}
