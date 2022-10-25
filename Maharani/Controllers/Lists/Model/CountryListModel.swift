//
//  CountryListModel.swift
//  HireEmirati
//
//  Created by Albin Jose on 22/12/21.
//

import Foundation

struct Country_Base : Codable {
    let status : String?
    let message : String?
    let oData : [CountryData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([CountryData].self, forKey: .oData)
    }

}

struct CountryData : Codable {
    let country_id : String?
    let country_name : String?
    let dial_code : String?
    let country_logo : String?

    enum CodingKeys: String, CodingKey {

        case country_id = "country_id"
        case country_name = "country_name"
        case dial_code = "dial_code"
        case country_logo = "country_logo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        dial_code = try values.decodeIfPresent(String.self, forKey: .dial_code)
        country_logo = try values.decodeIfPresent(String.self, forKey: .country_logo)
    }

}


struct City_Base : Codable {
    let status : String?
    let message : String?
    let oData : [CityData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([CityData].self, forKey: .oData)
    }

}

struct CityData : Codable {
    let city_id : String?
    let city_name : String?
   

    enum CodingKeys: String, CodingKey {

        case city_id = "city_id"
        case city_name = "city_name"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        
    }

}

struct Area_Base : Codable {
    let status : String?
    let message : String?
    let oData : [AreaData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([AreaData].self, forKey: .oData)
    }

}

struct AreaData : Codable {
    let area_name_english : String?
    let transport_amount : String?
    let area_id : String?


    enum CodingKeys: String, CodingKey {

        case area_name_english = "area_name_english"
        case transport_amount = "transport_amount"
        case area_id = "area_id"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        area_name_english = try values.decodeIfPresent(String.self, forKey: .area_name_english)
        transport_amount = try values.decodeIfPresent(String.self, forKey: .transport_amount)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
    }

}
