//
//  TaskTabSectionItemDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskTabSectionItemDto: Codable {
    var sequence: Int32?
    var itemViewType: String?
    var additionalItemAction: String?
    var itemId: Int32?
    var code: String?
    var dictionaryName: String?
    var parentCode: String?
    var propertyClass: String?
    var isRequired: Bool?
    var coolDownTime: Int32?
    var itemLabelValuesPairList: [ItemLabelValuesPairDto]?
    var parentId: Int32?
    
}
