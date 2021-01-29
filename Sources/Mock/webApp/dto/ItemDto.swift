//
//  ItemDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ItemListDto: Codable {
    var items: [ItemDto]?
}


class ItemDto: Codable {
    
    var id: Int32?
    var statusId: Int32?
    var externalId: String?
    var name: String?
    var itemValues: [InventoryItemValueDto]?
    var transitionValues: [CustomPropertyDto]?
    var editTab: TaskTabDto?
    var amount: Float?
    var itemTypeId: Int32?
    var javaClass: String? = "com.comarch.fsm.fe.mobile.item.ItemDto"
    
    enum CodingKeys: String, CodingKey {
        case id
        case statusId
        case name
        case itemValues = "itemAdditionalAttributes"
        case transitionValues = "itemTransitionAdditionalAttributes"
        case editTab = "itemAdditionalAttributesTab"
        case amount
        case itemTypeId
        case javaClass = "@class"
        case externalId
    }
}


class InventoryItemValueDto: Codable {
    
    var attributeTypeId: Int32?
    var name: String?
    var dictionaryCode: String?
    var value: ItemValueDto?
    
}
