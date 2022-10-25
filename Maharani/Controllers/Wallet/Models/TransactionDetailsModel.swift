//
//  TransactionDetailsModel.swift
//  Maharani
//
//  Created by Albin Jose on 20/01/22.
//

import Foundation

struct Transaction_Base : Codable {
    let status : String?
    let message : String?
    let oData : TransactionData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case oData = "oData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        oData = try values.decodeIfPresent(TransactionData.self, forKey: .oData)
    }

}

struct TransactionData : Codable {
    let list_data : [List_data]?
    let wallet_total : String?

    enum CodingKeys: String, CodingKey {

        case list_data = "list_data"
        case wallet_total = "wallet_total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list_data = try values.decodeIfPresent([List_data].self, forKey: .list_data)
        wallet_total = try values.decodeIfPresent(String.self, forKey: .wallet_total)
    }

}

struct List_data : Codable {
    let wallet_id : String?
    let transaction_id : String?
    let amount_type : String?
    let amount : String?
    let created_date_time : String?

    enum CodingKeys: String, CodingKey {

        case wallet_id = "wallet_id"
        case transaction_id = "transaction_id"
        case amount_type = "amount_type"
        case amount = "amount"
        case created_date_time = "created_date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        wallet_id = try values.decodeIfPresent(String.self, forKey: .wallet_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        amount_type = try values.decodeIfPresent(String.self, forKey: .amount_type)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        created_date_time = try values.decodeIfPresent(String.self, forKey: .created_date_time)
    }

}
