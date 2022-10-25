//
//  NotificationModel.swift
//  Oodle
//
//  Created by Albin Jose on 04/12/21.
//

import Foundation

class NotificationModel: Codable {
    var key : String?
    let title : String?
    let orderID : String?
    let description : String?
    let notificationType : String?
    let read : String?
    let seen : String?
    let createdAt : String?
    let imageURL : String?
    let url : String?
    let request_type : String?

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case title = "title"
        case orderID = "orderID"
        case description = "description"
        case notificationType = "notificationType"
        case read = "read"
        case seen = "seen"
        case createdAt = "createdAt"
        case imageURL = "imageURL"
        case url = "url"
        case request_type = "serviceType"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        orderID = try values.decodeIfPresent(String.self, forKey: .orderID)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        notificationType = try values.decodeIfPresent(String.self, forKey: .notificationType)
        read = try values.decodeIfPresent(String.self, forKey: .read)
        seen = try values.decodeIfPresent(String.self, forKey: .seen)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        request_type = try values.decodeIfPresent(String.self, forKey: .request_type)
    }
}
