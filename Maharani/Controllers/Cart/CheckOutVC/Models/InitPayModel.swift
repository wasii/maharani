//
//  InitPayModel.swift
//  Maharani
//
//  Created by Albin Jose on 04/02/22.
//

import Foundation

struct InitPayment_Base : Codable {
    let status : String?
    let message : String?
    let oData : InitPayment_Data?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(InitPayment_Data.self, forKey: .oData)
    }

}

struct InitPayment_Data : Codable {
    let stripe_key : String?
    enum CodingKeys: String, CodingKey {

        case stripe_key = "stripe_key"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stripe_key = try values.decodeIfPresent(String.self, forKey: .stripe_key)
    }

}
