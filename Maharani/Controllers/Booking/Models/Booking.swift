//
//  Authentication.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation


struct Booking_base : Codable {
    let status : String?
    let message : String?
    let oData : BookingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(BookingData.self, forKey: .oData)
    }

}
struct BookingData : Codable {
    let result_count : String?
    let result : [Booking]?

    enum CodingKeys: String, CodingKey {

        case result_count = "result_count"
        case result = "result"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result_count = try values.decodeIfPresent(String.self, forKey: .result_count)
        result = try values.decodeIfPresent([Booking].self, forKey: .result)
        
    }

}


struct Booking : Codable {
    
    let order_block_id : String?
    let order_no : String?
    let order_placed_date : String?
    let order_status : String?
    let customer_id : String?
    let customer_first_name : String?
    let customer_last_name : String?
    let billing_address_id : String?
    let shipping_address_id : String?
    let sub_total : String?
    let tax : String?
    let tax_percentage : String?
    let shipping_charge : String?
    let ordertime_slot : String?
    let total_products : String?
    let total_quantity : String?
    let grand_total : String?
    let service_name : String?
    let discount_price : String?
    let store_name : String?
    let order_status_label : String?
    let payment_type : String?
    let shipping_address : [shippingaddress]?
    let services : [Services]?
    let actual_amount_paid : String?
    let transport_amount: String?
    let staff_details: BookingStaffDetail?
   
    enum CodingKeys: String, CodingKey {

        case order_block_id  = "order_block_id"
        case order_no =  "order_no"
        case order_placed_date = "order_placed_date"
        case order_status = "order_status"
        case customer_id = "customer_id"
        case customer_first_name = "customer_first_name"
        case customer_last_name = "customer_last_name"
        case billing_address_id = "billing_address_id"
        case shipping_address_id = "shipping_address_id"
        case sub_total = "sub_total"
        case tax = "tax"
        case tax_percentage = "tax_percentage"
        case shipping_charge = "shipping_charge"
        case ordertime_slot = "ordertime_slot"
        case total_products = "total_products"
        case total_quantity = "total_quantity"
        case grand_total = "grand_total"
        case service_name = "service_name"
        case discount_price = "discount_price"
        case store_name = "store_name"
        case order_status_label = "order_status_label"
        case shipping_address = "shipping_address"
        case services = "services"
        case payment_type = "payment_type"
        case actual_amount_paid = "actual_amount_paid"
        case transport_amount = "transport_amount"
        case staff_details = "staff_details"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_block_id = try values.decodeIfPresent(String.self, forKey: .order_block_id)
        order_no = try values.decodeIfPresent(String.self, forKey: .order_no)
        order_placed_date = try values.decodeIfPresent(String.self, forKey: .order_placed_date)
        order_status = try values.decodeIfPresent(String.self, forKey: .order_status)
        customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
        customer_first_name = try values.decodeIfPresent(String.self, forKey: .customer_first_name)
        customer_last_name = try values.decodeIfPresent(String.self, forKey: .customer_last_name)
        billing_address_id = try values.decodeIfPresent(String.self, forKey: .billing_address_id)
        shipping_address_id = try values.decodeIfPresent(String.self, forKey: .shipping_address_id)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        tax_percentage = try values.decodeIfPresent(String.self, forKey: .tax_percentage)
        shipping_charge = try values.decodeIfPresent(String.self, forKey: .shipping_charge)
        ordertime_slot = try values.decodeIfPresent(String.self, forKey: .ordertime_slot)
        total_products = try values.decodeIfPresent(String.self, forKey: .total_products)
        total_quantity = try values.decodeIfPresent(String.self, forKey: .total_quantity)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        discount_price = try values.decodeIfPresent(String.self, forKey: .discount_price)
        store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
        order_status_label = try values.decodeIfPresent(String.self, forKey: .order_status_label)
        shipping_address = try values.decodeIfPresent([shippingaddress].self, forKey: .shipping_address)
        services = try values.decodeIfPresent([Services].self, forKey: .services)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        actual_amount_paid = try values.decodeIfPresent(String.self, forKey: .actual_amount_paid)
        transport_amount = try values.decodeIfPresent(String.self, forKey: .transport_amount)
        staff_details = try values.decodeIfPresent(BookingStaffDetail.self, forKey: .staff_details)
    }

}

struct shippingaddress : Codable {
    
    let user_shiping_details_phone : String?
    let user_shiping_details_loc : String?
    let user_shiping_details_street : String?
    let user_shiping_details_building : String?
    let user_shiping_details_landmark : String?
    let user_shiping_details_status : String?
    let user_shiping_details_floorno : String?
    let user_shiping_details_flatno : String?
    let user_shiping_details_note : String?
    let user_shiping_details_city : String?
    let user_shiping_details_area : String?
    let user_shiping_details_user_id : String?
    let user_shiping_details_id : String?
    let user_shiping_details_loc_type : String?
    let user_shiping_details_latitude : String?
    let user_shiping_details_longitude : String?
    let user_shiping_country_id : String?
    let first_name : String?
    let last_name : String?
    let user_shiping_zipcode : String?
    let default_address_status : String?
    
    let user_shipping_email : String?
    let remind_address : String?
    let user_shiping_details_dial_code : String?
    let user_id : String?
    let user_first_name : String?
    let user_last_name : String?
    let user_country_id : String?
    let user_email_id : String?
    let country_name : String?
    let city_name : String?
    
    let area_name : String?
    
   
    enum CodingKeys: String, CodingKey {

        case user_shiping_details_phone  = "user_shiping_details_phone"
        case user_shiping_details_loc =  "user_shiping_details_loc"
        case user_shiping_details_street = "user_shiping_details_street"
        case user_shiping_details_building = "user_shiping_details_building"
        case user_shiping_details_landmark = "user_shiping_details_landmark"
        case user_shiping_details_status = "user_shiping_details_status"
        case user_shiping_details_floorno = "user_shiping_details_floorno"
        case user_shiping_details_flatno = "user_shiping_details_flatno"
        case user_shiping_details_note = "user_shiping_details_note"
        case user_shiping_details_city = "user_shiping_details_city"
        case user_shiping_details_area = "user_shiping_details_area"
        case user_shiping_details_user_id = "user_shiping_details_user_id"
        case user_shiping_details_id = "user_shiping_details_id"
        case user_shiping_details_loc_type = "user_shiping_details_loc_type"
        case user_shiping_details_latitude = "user_shiping_details_latitude"
        case user_shiping_details_longitude = "user_shiping_details_longitude"
        case user_shiping_country_id = "user_shiping_country_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case user_shiping_zipcode = "user_shiping_zipcode"
        case default_address_status = "default_address_status"
        case user_shipping_email = "user_shipping_email"
        case remind_address = "remind_address"
        case user_shiping_details_dial_code = "user_shiping_details_dial_code"
        case user_id = "user_id"
        case user_first_name = "user_first_name"
        case user_last_name = "user_last_name"
        case user_country_id = "user_country_id"
        case user_email_id = "user_email_id"
        case country_name = "country_name"
        case city_name = "city_name"
        case area_name = "area_name"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_shiping_details_phone = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_phone)
        user_shiping_details_loc = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_loc)
        user_shiping_details_street = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_street)
        user_shiping_details_building = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_building)
        user_shiping_details_landmark = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_landmark)
        user_shiping_details_status = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_status)
        user_shiping_details_floorno = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_floorno)
        user_shiping_details_flatno = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_flatno)
        user_shiping_details_note = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_note)
        user_shiping_details_city = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_city)
        user_shiping_details_area = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_area)
        user_shiping_details_user_id = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_user_id)
        user_shiping_details_id = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_id)
        user_shiping_details_loc_type = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_loc_type)
        user_shiping_details_latitude = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_latitude)
        user_shiping_details_longitude = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_longitude)
        user_shiping_country_id = try values.decodeIfPresent(String.self, forKey: .user_shiping_country_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        user_shiping_zipcode = try values.decodeIfPresent(String.self, forKey: .user_shiping_zipcode)
        default_address_status = try values.decodeIfPresent(String.self, forKey: .default_address_status)
        
        user_shipping_email = try values.decodeIfPresent(String.self, forKey: .user_shipping_email)
        remind_address = try values.decodeIfPresent(String.self, forKey: .remind_address)
        user_shiping_details_dial_code = try values.decodeIfPresent(String.self, forKey: .user_shiping_details_dial_code)
        user_first_name = try values.decodeIfPresent(String.self, forKey: .user_first_name)
        user_last_name = try values.decodeIfPresent(String.self, forKey: .user_last_name)
        user_country_id = try values.decodeIfPresent(String.self, forKey: .user_country_id)
        user_email_id = try values.decodeIfPresent(String.self, forKey: .user_email_id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)

    }

}


struct BookingDetails_base : Codable {
    let status : String?
    let message : String?
    let oData : Booking?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(Booking.self, forKey: .oData)
    }

}


struct BookingStaffDetail : Codable {
    let staff_address : String?
    let staff_contact_number : String?
    let staff_email_id : String?
    let staff_first_name : String?
    let staff_last_name: String?
    let staff_profile_image: String?
    let staff_idcard_image: String?
    let staff_nationality: String?
    let staff_store_id: String?

    enum CodingKeys: String, CodingKey {

        case staff_address = "staff_address"
        case staff_contact_number = "staff_contact_number"
        case staff_email_id = "staff_email_id"
        case staff_first_name = "staff_first_name"
        case staff_last_name = "staff_last_name"
        case staff_profile_image = "staff_profile_image"
        case staff_idcard_image = "staff_idcard_image"
        case staff_nationality = "staff_nationality"
        case staff_store_id = "staff_store_id"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        staff_address = try values.decodeIfPresent(String.self, forKey: .staff_address)
        staff_contact_number = try values.decodeIfPresent(String.self, forKey: .staff_contact_number)
        staff_email_id = try values.decodeIfPresent(String.self, forKey: .staff_email_id)
        staff_first_name = try values.decodeIfPresent(String.self, forKey: .staff_first_name)
        staff_last_name = try values.decodeIfPresent(String.self, forKey: .staff_last_name)
        staff_profile_image = try values.decodeIfPresent(String.self, forKey: .staff_profile_image)
        staff_idcard_image = try values.decodeIfPresent(String.self, forKey: .staff_idcard_image)
        staff_nationality = try values.decodeIfPresent(String.self, forKey: .staff_nationality)
        staff_store_id = try values.decodeIfPresent(String.self, forKey: .staff_store_id)
    }

}

