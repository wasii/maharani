//
//  Authentication.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation

struct address_base : Codable {
    let status : String?
    let message : String?
    let oData : [address]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([address].self, forKey: .oData)
    }

}
struct address : Codable {
    
    let shiping_details_id : String?
    let first_name : String?
    let last_name : String?
    let cutomer_name : String?
    let street_name : String?
    let building_name : String?
    let floor_no : String?
    let flat_no : String?
    let location : String?
    let land_mark : String?
    let city_name : String?
    let area_name: String?
    let country_name : String?
    let dial_code : String?
    let phone_no : String?
    let default_address : String?
    let address_type : String?
    let city_id : String?
    let country_id : String?
    let latitude : String?
    let longitude : String?
    let area_id: String?
    let transport_amount: String?
    
   
    enum CodingKeys: String, CodingKey {

        case shiping_details_id  = "shiping_details_id"
        case first_name =  "first_name"
        case last_name = "last_name"
        case cutomer_name = "cutomer_name"
        case street_name = "street_name"
        case building_name = "building_name"
        case floor_no = "floor_no"
        case flat_no = "flat_no"
        case location = "location"
        case land_mark = "land_mark"
        case city_name = "city_name"
        case country_name = "country_name"
        case dial_code = "dial_code"
        case phone_no = "phone_no"
        case default_address = "default_address"
        case address_type = "address_type"
        case city_id = "city_id"
        case country_id = "country_id"
        case latitude = "latitude"
        case longitude = "longitude"
        case area_name = "area_name"
        case area_id = "area_id"
        case transport_amount = "transport_amount"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shiping_details_id = try values.decodeIfPresent(String.self, forKey: .shiping_details_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        cutomer_name = try values.decodeIfPresent(String.self, forKey: .cutomer_name)
        street_name = try values.decodeIfPresent(String.self, forKey: .street_name)
        building_name = try values.decodeIfPresent(String.self, forKey: .building_name)
        floor_no = try values.decodeIfPresent(String.self, forKey: .floor_no)
        flat_no = try values.decodeIfPresent(String.self, forKey: .flat_no)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        land_mark = try values.decodeIfPresent(String.self, forKey: .land_mark)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        dial_code = try values.decodeIfPresent(String.self, forKey: .dial_code)
        phone_no = try values.decodeIfPresent(String.self, forKey: .phone_no)
        default_address = try values.decodeIfPresent(String.self, forKey: .default_address)
        address_type = try values.decodeIfPresent(String.self, forKey: .address_type)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        area_name = try values.decodeIfPresent(String.self, forKey: .area_name)
        area_id = try values.decodeIfPresent(String.self, forKey: .area_id)
        transport_amount = try values.decodeIfPresent(String.self, forKey: .transport_amount)
    }

}
