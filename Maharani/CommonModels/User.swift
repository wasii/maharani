//
//  User.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation

struct MHUser : Codable {
    let user_full_name : String?
    let user_first_name : String?
    let user_last_name : String?
    let user_email : String?
    let user_type : String?
    let user_id : String?
    let user_image : String?
    let login_type : String?
    let user_country_id : String?
    let country_name : String?
    let referal_code : String?
    let dial_code : String?
    let phone_number : String?
    let firebase_user_key : String?
    let temp_dial_code : String?
    let temp_phone_number : String?
    let points : String?
    let cash_points_in_currency : String?
    let signle_cash_point_value : String?
    let company_name : String?
    let trn_no : String?
    let user_location : String?
    let user_latitude : String?
    let user_longitude : String?
    let user_docs : String?
    let about_me : String?
    let accessToken : String?

    enum CodingKeys: String, CodingKey {

        case user_full_name = "user_full_name"
        case user_first_name = "user_first_name"
        case user_last_name = "user_last_name"
        case user_email = "user_email"
        case user_type = "user_type"
        case user_id = "user_id"
        case user_image = "user_image"
        case login_type = "login_type"
        case user_country_id = "user_country_id"
        case country_name = "country_name"
        case referal_code = "referal_code"
        case dial_code = "dial_code"
        case phone_number = "phone_number"
        case firebase_user_key = "firebase_user_key"
        case temp_dial_code = "temp_dial_code"
        case temp_phone_number = "temp_phone_number"
        case points = "points"
        case cash_points_in_currency = "cash_points_in_currency"
        case signle_cash_point_value = "signle_cash_point_value"
        case company_name = "company_name"
        case trn_no = "trn_no"
        case user_location = "user_location"
        case user_latitude = "user_latitude"
        case user_longitude = "user_longitude"
        case user_docs = "user_docs"
        case about_me = "about_me"
        case accessToken = "accessToken"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_full_name = try values.decodeIfPresent(String.self, forKey: .user_full_name)
        user_first_name = try values.decodeIfPresent(String.self, forKey: .user_first_name)
        user_last_name = try values.decodeIfPresent(String.self, forKey: .user_last_name)
        user_email = try values.decodeIfPresent(String.self, forKey: .user_email)
        user_type = try values.decodeIfPresent(String.self, forKey: .user_type)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        user_image = try values.decodeIfPresent(String.self, forKey: .user_image)
        login_type = try values.decodeIfPresent(String.self, forKey: .login_type)
        user_country_id = try values.decodeIfPresent(String.self, forKey: .user_country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        referal_code = try values.decodeIfPresent(String.self, forKey: .referal_code)
        dial_code = try values.decodeIfPresent(String.self, forKey: .dial_code)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        firebase_user_key = try values.decodeIfPresent(String.self, forKey: .firebase_user_key)
        temp_dial_code = try values.decodeIfPresent(String.self, forKey: .temp_dial_code)
        temp_phone_number = try values.decodeIfPresent(String.self, forKey: .temp_phone_number)
        points = try values.decodeIfPresent(String.self, forKey: .points)
        cash_points_in_currency = try values.decodeIfPresent(String.self, forKey: .cash_points_in_currency)
        signle_cash_point_value = try values.decodeIfPresent(String.self, forKey: .signle_cash_point_value)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        trn_no = try values.decodeIfPresent(String.self, forKey: .trn_no)
        user_location = try values.decodeIfPresent(String.self, forKey: .user_location)
        user_latitude = try values.decodeIfPresent(String.self, forKey: .user_latitude)
        user_longitude = try values.decodeIfPresent(String.self, forKey: .user_longitude)
        user_docs = try values.decodeIfPresent(String.self, forKey: .user_docs)
        about_me = try values.decodeIfPresent(String.self, forKey: .about_me)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
    }

}
