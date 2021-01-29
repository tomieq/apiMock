//
//  TaskItemDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskItemListDto: Codable {
    
    var taskItems: [TaskItemDto]?
}


class TaskItemDto: Codable {
    
    var className: String = "com.comarch.fsm.fe.mobile.item.TaskItemDto"
    var taskId: Int32?
    var taskItemId: Int32?
    var itemTypeId: Int32?
    var item: ItemDto?
    var relatedItems: [TaskItemDto]?
    var taskItemValues: [InventoryItemValueDto]?
    var createdByEmployee: Bool?
    var proposalCount: Int32?
    var additionalTabs: [AdditionalTabDto]?
    
    enum CodingKeys: String, CodingKey {
        case taskId
        case className = "@class"
        case taskItemId
        case itemTypeId
        case item
        case relatedItems
        case taskItemValues
        case createdByEmployee
        case proposalCount
        case additionalTabs
    }
}
