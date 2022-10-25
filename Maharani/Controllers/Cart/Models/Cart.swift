//
//  Authentication.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation

struct Cart_Base : Codable {
    let status : String?
    let message : String?
    let oData : Cart?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(Cart.self, forKey: .oData)
    }

}

struct Cart : Codable {
    
    

    let sub_total : String?
    let sub_total_wo_tax : String?
    let tax_percentage : String?
    var grand_total : String?
    let tax : String?
    let shipping_charge : String?
    let total_products : String?
    let total_quantity : String?
    let total_cart_cash_points : String?
    let currency : String?
    let cart_services : [CartServices]?
    
   
    enum CodingKeys: String, CodingKey {

        case sub_total  = "sub_total"
        case sub_total_wo_tax =  "sub_total_wo_tax"
        case tax_percentage = "tax_percentage"
        case grand_total = "grand_total"
        case tax = "tax"
        case shipping_charge = "shipping_charge"
        case total_products = "total_products"
        case total_quantity = "total_quantity"
        case total_cart_cash_points = "total_cart_cash_points"
        case currency = "currency"
        case cart_services = "cart_services"
        
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        sub_total_wo_tax = try values.decodeIfPresent(String.self, forKey: .sub_total_wo_tax)
        tax_percentage = try values.decodeIfPresent(String.self, forKey: .tax_percentage)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        tax = try values.decodeIfPresent(String.self, forKey: .tax)
        shipping_charge = try values.decodeIfPresent(String.self, forKey: .shipping_charge)
        total_products = try values.decodeIfPresent(String.self, forKey: .total_products)
        total_quantity = try values.decodeIfPresent(String.self, forKey: .total_quantity)
        total_cart_cash_points = try values.decodeIfPresent(String.self, forKey: .total_cart_cash_points)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        cart_services = try values.decodeIfPresent([CartServices].self, forKey: .cart_services)
    }

}

struct CartServices : Codable {

    let cart_id : String?
    let service_id : String?
    let cart_quantity : String?
    let user_id : String?
    let service_vendor_user_id : String?
    let service_name : String?
    let service_description : String?
    let sale_price : String?
    let sub_total_bc : String?
    let sub_total : String?
    let shipping_charge_bc : String?
    let shipping_charge : String?
    let product_total_bc : String?
    let cash_points : String?
    let comment : String?
    let vendor_commission : String?
    let service_image : String?
    let coupon_discount : String?
    let service_slot_datetime : String?
    let service_slot_date : String?
    let driver_earnings : String?
   
    enum CodingKeys: String, CodingKey {

        case cart_id  = "cart_id"
        case service_id =  "service_id"
        case cart_quantity = "cart_quantity"
        case user_id = "user_id"
        case service_vendor_user_id = "service_vendor_user_id"
        case service_name = "service_name"
        case service_description = "service_description"
        case sale_price = "sale_price"
        case sub_total_bc = "sub_total_bc"
        case sub_total = "sub_total"
        case shipping_charge_bc = "shipping_charge_bc"
        case cash_points = "cash_points"
        case comment = "comment"
        case vendor_commission = "vendor_commission"
        case service_image = "service_image"
        case coupon_discount = "coupon_discount"
        case service_slot_datetime = "service_slot_datetime"
        case service_slot_date = "service_slot_date"
        case driver_earnings = "driver_earnings"
        case shipping_charge = "shipping_charge"
        case product_total_bc =  "product_total_bc"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        cart_quantity = try values.decodeIfPresent(String.self, forKey: .cart_quantity)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        service_vendor_user_id = try values.decodeIfPresent(String.self, forKey: .service_vendor_user_id)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        service_description = try values.decodeIfPresent(String.self, forKey: .service_description)
        sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
        sub_total_bc = try values.decodeIfPresent(String.self, forKey: .sub_total_bc)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        shipping_charge_bc = try values.decodeIfPresent(String.self, forKey: .shipping_charge_bc)
        cash_points = try values.decodeIfPresent(String.self, forKey: .cash_points)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        vendor_commission = try values.decodeIfPresent(String.self, forKey: .vendor_commission)
        service_image = try values.decodeIfPresent(String.self, forKey: .service_image)
        coupon_discount = try values.decodeIfPresent(String.self, forKey: .coupon_discount)
        service_slot_datetime = try values.decodeIfPresent(String.self, forKey: .service_slot_datetime)
        service_slot_date = try values.decodeIfPresent(String.self, forKey: .service_slot_date)
        driver_earnings = try values.decodeIfPresent(String.self, forKey: .driver_earnings)
        product_total_bc = try values.decodeIfPresent(String.self, forKey: .product_total_bc)
        shipping_charge = try values.decodeIfPresent(String.self, forKey: .shipping_charge)
    }

}

struct TimeSlot_Base : Codable {
    let status : String?
    let message : String?
    let oData : [TimeSlots]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([TimeSlots].self, forKey: .oData)
    }

}

struct TimeSlots : Codable {
    
    let time_slot : String?
    let time_slot_formated : String?
    var available : String?

   
    enum CodingKeys: String, CodingKey {

        case time_slot  = "time_slot"
        case time_slot_formated =  "time_slot_formated"
        case available = "available"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        time_slot = try values.decodeIfPresent(String.self, forKey: .time_slot)
        time_slot_formated = try values.decodeIfPresent(String.self, forKey: .time_slot_formated)
        available = try values.decodeIfPresent(String.self, forKey: .available)
       
    }

}

struct Checkout_Base : Codable {
    let status : String?
    let message : String?
    let oData : CheckOut?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(CheckOut.self, forKey: .oData)
    }

}

struct CheckOut : Codable {

    let coupon_applied_stat : String?
    let coupon_id : String?
    let coupon_code : String?
    let coupon_discount : String?
    let sub_total : String?
    let grand_total : String?
    let sale_price : String?
   
   
    enum CodingKeys: String, CodingKey {

        case coupon_applied_stat  = "coupon_applied_stat"
        case coupon_id =  "coupon_id"
        case coupon_code = "coupon_code"
        case coupon_discount = "coupon_discount"
        case sub_total = "sub_total"
        case grand_total = "grand_total"
        case sale_price = "sale_price"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coupon_applied_stat = try values.decodeIfPresent(String.self, forKey: .coupon_applied_stat)
        coupon_id = try values.decodeIfPresent(String.self, forKey: .coupon_id)
        coupon_code = try values.decodeIfPresent(String.self, forKey: .coupon_code)
        coupon_discount = try values.decodeIfPresent(String.self, forKey: .coupon_discount)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
        sale_price = try values.decodeIfPresent(String.self, forKey: .sale_price)
        sub_total = try values.decodeIfPresent(String.self, forKey: .sub_total)
        
    }

}

struct PlaceOrder_Base : Codable {
    let status : String?
    let message : String?
    let oData : PlaceOrder?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(PlaceOrder.self, forKey: .oData)
    }

}
struct PlaceOrder : Codable {

    let order_no : String?
    let order_id : String?

    enum CodingKeys: String, CodingKey {

        case order_no  = "order_no"
        case order_id =  "order_id"
        
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_no = try values.decodeIfPresent(String.self, forKey: .order_no)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        
        
    }

}
