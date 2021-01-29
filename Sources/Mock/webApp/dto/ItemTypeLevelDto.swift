//
//  ItemTypeLevelDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ItemTypeLevelListDto: Codable {
    var itemTypesLevels: [ItemTypeLevelDto]?
}

class ItemTypeLevelDto: Codable {
    
    var id: Int32?
    var name: String?
    var code: String?
    var isFinal: Bool?
}
