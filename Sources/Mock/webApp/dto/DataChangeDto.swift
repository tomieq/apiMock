//
//  DataChangeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class DataChangeListDto: Codable {
    var list: [DataChangeDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "notifications"
    }
}

class DataChangeDto: Codable {
    
    var id: Int32?
    var objectId: Int32?
    var objectType: ObjectType?
    var changeType: ChangeType?
    var objectTypeRaw: String?
    var changeTypeRaw: String?
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32?.self, forKey: .id)
        self.objectId = try container.decode(Int32?.self, forKey: .objectId)
        self.objectType = try container.decode(ObjectType?.self, forKey: .objectType)
        self.changeType = try container.decode(ChangeType?.self, forKey: .changeType)
        self.objectTypeRaw = self.objectType?.rawValue
        self.changeTypeRaw = self.changeType?.rawValue
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case objectId
        case objectType
        case changeType
    }
}


extension DataChangeDto {
    
    enum ObjectType: String, Codable {
        case task = "TASK"
        case taskItem = "TASK_ITEM"
        case taskType = "TASK_TYPE"
        case systemParameter = "SYSTEM_PARAMETER"
        case calendarEvent = "CALENDAR_EVENT"
        case calendarEventType = "CALENDAR_EVENT_TYPE"
        case dictionaryEntry = "DICTIONARY_ENTRY"
        case status = "STATUS"
        case message = "MESSAGE"
        case userDeactivated = "USER_DEACTIVATED"
        case applicationUpdated = "APPLICATION_UPDATED"
        case item = "ITEM"
        case userData = "USER_DATA"
        case taskConfig = "TASK_CONFIG"
        case document = "DOCUMENT"
        case contact = "MOBILE_CONTACT"
        case transfer = "ITEM_TRANSFER"
        case transferType = "TRANSFER_TYPE"
        case translations = "TRANSLATIONS"
        case taskComplex = "TASK_COMPLEX"
        case unknown = "UNKNOWN"
    }
    
    enum ChangeType: String, Codable {
        case insert = "INSERT"
        case update = "UPDATE"
        case delete = "DELETE"
        case unknown = "UNKNOWN"
    }
}
