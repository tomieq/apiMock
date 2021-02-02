//
//  MessageDto.swift
//  
//
//  Created by Tomasz Kucharski on 02/02/2021.
//

import Foundation

class MessageListDto: Codable {
    var list: [MessageDto]?

    enum CodingKeys: String, CodingKey {
        case list = "messages"
    }
}

class MessageDto: Codable {
    
    var id: Int32?
    var content: String?
    var senderFullName: String?
    var senderPhoneNumber: String?
    var status: String?
    var readDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_readDate)
        }
        set(newReadDate) {
            _readDate = MobileApiDateTransform().transformToJSON(newReadDate)
        }
    }
    private var _readDate: Double?
    var createDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_createDate)
        }
        set(newCreateDate) {
            _createDate = MobileApiDateTransform().transformToJSON(newCreateDate)
        }
    }
    private var _createDate: Double?
    var priority: String?
    var senderId: Int32?
    var recipientId: Int32?
    var recipientDisplayName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case senderFullName
        case senderPhoneNumber
        case status
        case _readDate = "readDate"
        case _createDate = "createDate"
        case priority
        case senderId
        case recipientId
        case recipientDisplayName
    }
}
