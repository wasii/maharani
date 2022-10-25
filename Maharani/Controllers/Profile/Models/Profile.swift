//
//  Authentication.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation

struct Profile : Codable {
    let status : String?
    let message : String?
    let total_booking : String?
    let total_completed : String?
    let total_missed : String?
    let oData : MHUser?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case total_booking = "total_booking"
        case total_completed = "total_completed"
        case total_missed = "total_missed"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        total_booking = try values.decodeIfPresent(String.self, forKey: .total_booking)
        total_completed = try values.decodeIfPresent(String.self, forKey: .total_completed)
        total_missed = try values.decodeIfPresent(String.self, forKey: .total_missed)
        oData = try values.decodeIfPresent(MHUser.self, forKey: .oData)
    }

}
