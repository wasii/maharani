//
//  AppliedJobList.swift
//  HireEmirati
//
//  Created by Albin Jose on 31/12/21.
//

import Foundation

struct Home_Base : Codable {
    let status : String?
    let message : String?
    let oData : HomeListData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(HomeListData.self, forKey: .oData)
    }

}

struct Services_Base : Codable {
    let status : String?
    let message : String?
    let oData : ServicesListData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(ServicesListData.self, forKey: .oData)
    }

}

struct HomeListData: Codable {
    let pramotinal_banners: [PramotionBanners]?
    let category_list: [Category]?

    enum CodingKeys: String, CodingKey {
        case pramotinal_banners = "pramotinal_banners"
        case category_list = "category_list"
    }
}

struct ServicesListData: Codable {
    let service_slider: [PramotionBanners]?
    let service_list: [Services]?

    enum CodingKeys: String, CodingKey {
        case service_slider = "service_slider"
        case service_list = "service_list"
    }
}


struct PramotionBanners : Codable {
    
    let pramotion_id : String?
    let category_id : String?
    let title : String?
    let image_path : String?
    let created_at : String?
    let type : String?

    enum CodingKeys: String, CodingKey {
        
        case pramotion_id = "pramotion_id"
        case category_id = "category_id"
        case title = "title"
        case image_path = "image_path"
        case created_at = "created_at"
        case type = "type"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pramotion_id = try values.decodeIfPresent(String.self, forKey: .pramotion_id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image_path = try values.decodeIfPresent(String.self, forKey: .image_path)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        
    }

}


struct Category : Codable {
    
    let category_image : String?
    let category_id : String?
    let category_name : String?
    let category_uid : String?
    

    enum CodingKeys: String, CodingKey {
        
        case category_image = "category_image"
        case category_id = "category_id"
        case category_name = "category_name"
        case category_uid = "category_uid"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_image = try values.decodeIfPresent(String.self, forKey: .category_image)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_uid = try values.decodeIfPresent(String.self, forKey: .category_uid)
        
        
    }

}


struct Services : Codable {
    
    let service_id : String?
    let service_name : String?
    let service_arabic : String?
    let service_description : String?
    let service_description_arabic : String?
    let category_id : String?
    let service_price : String?
    let service_image : String?
    let product_total : String?
    let coupon_discount : String?
    let purchase_qty : String?
    

    enum CodingKeys: String, CodingKey {
        case service_id = "service_id"
        case service_name = "service_name"
        case service_arabic = "service_arabic"
        case service_description = "service_description"
        case service_description_arabic = "service_description_arabic"
        case category_id = "category_id"
        case service_price = "service_price"
        case service_image = "service_image"
        case product_total = "product_total"
        case coupon_discount = "coupon_discount"
        case purchase_qty = "purchase_qty"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        service_arabic = try values.decodeIfPresent(String.self, forKey: .service_arabic)
        service_description = try values.decodeIfPresent(String.self, forKey: .service_description)
        service_description_arabic = try values.decodeIfPresent(String.self, forKey: .service_description_arabic)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        service_price = try values.decodeIfPresent(String.self, forKey: .service_price)
        service_image = try values.decodeIfPresent(String.self, forKey: .service_image)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        product_total = try values.decodeIfPresent(String.self, forKey: .product_total)
        coupon_discount = try values.decodeIfPresent(String.self, forKey: .coupon_discount)
        purchase_qty = try values.decodeIfPresent(String.self, forKey: .purchase_qty)
        
    }

}



struct HomeBaseData_Base : Codable {
    let status : String?
    let message : String?
    let oData : HomeBaseData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(HomeBaseData.self, forKey: .oData)
    }

}
struct HomeBaseData : Codable {
    let email : String?
    let address : String?
    let phone : String?
    let facebook : String?
    let twitter : String?
    let instagram : String?
    let youtube : String?
    let linkedin : String?
    let total_products : String?
    let total_quantity : String?
    let user_invite_code : String?
    let user_invite_url : String?
    let user_invite_message : String?

    enum CodingKeys: String, CodingKey {

        case email = "email"
        case address = "address"
        case phone = "phone"
        case facebook = "facebook"
        case twitter = "twitter"
        case instagram = "instagram"
        case youtube = "youtube"
        case linkedin = "linkedin"
        case total_products = "total_products"
        case total_quantity = "total_quantity"
        case user_invite_code = "user_invite_code"
        case user_invite_url = "user_invite_url"
        case user_invite_message = "user_invite_message"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
        twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
        instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
        youtube = try values.decodeIfPresent(String.self, forKey: .youtube)
        linkedin = try values.decodeIfPresent(String.self, forKey: .linkedin)
        total_products = try values.decodeIfPresent(String.self, forKey: .total_products)
        total_quantity = try values.decodeIfPresent(String.self, forKey: .total_quantity)
        user_invite_code = try values.decodeIfPresent(String.self, forKey: .user_invite_code)
        user_invite_url = try values.decodeIfPresent(String.self, forKey: .user_invite_url)
        user_invite_message = try values.decodeIfPresent(String.self, forKey: .user_invite_message)
    }

}

