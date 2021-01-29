//
//  ConfigurationComponentDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ConfigurationComponentListDto: Codable {
    var list: [ConfigurationComponentDto]?
    var componentByTypeList: [ConfigurationComponentByTypeDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "componentDtos"
        case componentByTypeList = "componentByTypeDtos"
    }
}


enum ComponentType: String, Codable {
    case module = "MODULE"
    case tabMenuItem = "TAB_MENU_ITEM"
    case section = "SECTION"
    case button = "BUTTON"
    case unknown = "UNKNOWN"
}
    
enum ComponentCode: String, Codable {
    // modules
    case supervisor = "MOBILE_SUPERVISOR_MODULE"
    case tasks = "MOBILE_TASKS_MODULE"
    case absence = "MOBILE_ABSENCE_MODULE"
    case technicianMap = "MOBILE_TECHNICIAN_MAP_MODULE"
    case supervisorMap = "MOBILE_SUPERVISOR_MAP_MODULE"
    case rescheduling = "MOBILE_RESCHEDULING_MODULE"
    case newTask = "MOBILE_NEW_TASK_MODULE"
    case messages = "MOBILE_MESSAGES_MODULE"
    case warehouse = "MOBILE_WAREHOUSE_MODULE"
    case transfers = "MOBILE_TRANSFERS_MODULE"
    case transferRequests = "MOBILE_TRANSFER_REQUESTS_MODULE"
    case calendar = "MOBILE_CALENDAR_MODULE"
    case contacts = "MOBILE_CONTACT_LIST_MODULE"
    case qrItemScanner = "MOBILE_QR_ITEM_SCANNER_MODULE"
    case inventoryMock = "MOBILE_INVENTORY_MOCK_MODULE"
    case tasksNearby = "MOBILE_TASKS_NEARBY_COMPONENT"
    // buttons
    case addAnnouncementButton = "MOBILE_ADD_ANNOUNCEMENT_BUTTON"
    case removeItemButton = "MOBILE_REMOVE_ITEM_FROM_ANNOUNCEMENT_BUTTON"
    case addItemButton = "ADD_ITEM_BUTTON"
    case chooseItemButton = "CHOOSE_ITEM_BUTTON"
    case addPictureFromGalleryButton = "MOBILE_PHOTO_GALLERY_BUTTON"
    case changeItemStatusButton = "MOBILE_CHANGE_ITEM_STATUS_BUTTON"
    case saveAuditButton = "MOBILE_SAVE_AND_SENT_AUDIT_BUTTON"
    case closeAuditButton = "MOBILE_SAVE_SENT_AND_CLOSE_AUDIT_BUTTON"
    case deleteAttachmentFromServer = "MOBILE_DELETE_ATTACHMENT_FROM_SERVER_BUTTON"
    case taskDelegationButton = "MOBILE_TASK_REASSIGN_BUTTON"
    case itemEditButton = "EDIT_ITEM_BUTTON"
    case unknown = "UNKNOWN"
}

class ConfigurationComponentDto : Codable {
    
    var type: ComponentType?
    var code: ComponentCode?
    var sequence: Int32?
}


class ConfigurationComponentByTypeDto : ConfigurationComponentDto {
    var typeList: [ConfigurationComponentTypeDto]?
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.typeList = try container.decode([ConfigurationComponentTypeDto]?.self, forKey: .typeList)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(typeList, forKey: .typeList)
        try super.encode(to: encoder)
    }

    enum CodingKeys: String, CodingKey {
        case typeList = "typesForVisibility"
    }
}


class ConfigurationComponentTypeDto: Codable {
    var id: Int32?
    var statusList: [Int32]?

    enum CodingKeys: String, CodingKey {
        case id
        case statusList = "statusIds"
    }
}
