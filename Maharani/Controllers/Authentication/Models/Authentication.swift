//
//  Authentication.swift
//  Maharani
//
//  Created by Albin Jose on 12/01/22.
//

import Foundation

struct Authentication_Base : Codable {
    let status : String?
    let oTPVerify : String?
    let OTP : String?
    let message : String?
    let accessToken : String?
    let oData : MHUser?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case oTPVerify = "OTPVerify"
        case message = "message"
        case accessToken = "accessToken"
        case OTP = "OTP"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        oTPVerify = try values.decodeIfPresent(String.self, forKey: .oTPVerify)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        OTP = try values.decodeIfPresent(String.self, forKey: .OTP)
        oData = try values.decodeIfPresent(MHUser.self, forKey: .oData)
    }

}



