//
//  ItemTypeImpactDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class ItemTypeImpactListDto: Codable {
    var list: [ItemTypeImpactDto]?
    enum CodingKeys: String, CodingKey {
        case list = "itemTypes"
    }
}

class ItemTypeImpactDto: Codable {
    var id: Int32?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "itemTypeId"
        case name = "itemTypeName"
    }
}
