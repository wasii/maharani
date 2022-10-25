//
//  HEGeneralModel.swift
//  HireEmirati
//
//  Created by Albin Jose on 22/12/21.
//

import Foundation

struct MAGeneralModel : Codable {
    let status : String?
    let message : String?
    let oData : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
         case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(String.self, forKey: .oData)
    }

}

struct MAGeneralForAddressModel : Codable {
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}


