//
//  ItemTypeClassDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ItemTypeClassListDto: Codable {
    var itemTypesClasses: [ItemTypeClassDto]?
}

class ItemTypeClassDto: Codable {
    
    var id: Int32?
    var name: String?
    var code: String?
    var canBeCreatedAsAnnouncement: Bool?
    var canBeDeleted: Bool?
    var canBeChanged: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case canBeCreatedAsAnnouncement
        case canBeDeleted = "itemCanBeDeleted"
        case canBeChanged = "itemCanBeChanged"
    }
}
