//
//  ItemTypeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ItemTypeListDto: Codable {
    var list: [ItemTypeDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "itemTypes"
    }
}

class ItemTypeDto: Codable {
    
    var id: Int32?
    var parentId: Int32?
    var typeName: String?
    var itemClass: String?
    var code: String?
    var countable: Bool?
    var serializable: Bool?
    var itemAttributes: [ItemTypeAttributeDto]? = [] // atrybuty dla tego typu itema
    var itemProposalAttributes: [ItemTypeAttributeDto]? = [] // atrybuty, które pojawiają się podczas tworzenia tego typu zapowiedzi
    var levelId: Int32?
    var canBeCreatedAsAnnouncement: Bool? // definiuje, czy dla tego typu użytkownik może tworzyć zapowiedź
    
}
