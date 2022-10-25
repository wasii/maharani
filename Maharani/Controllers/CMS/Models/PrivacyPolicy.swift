//
//  PrivacyPolicy.swift
//  HireEmirati
//
//  Created by Albin Jose on 01/01/22.
//

import Foundation

struct privacy_Base : Codable {
    let status : String?
    let message : String?
    let oData : [PrivacyData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent([PrivacyData].self, forKey: .oData)
    }

}

struct PrivacyData : Codable {
    let title : String?
    let description : String?
    var expand :Bool?
    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        expand = false
    }

}
