//
//  ComplexCustomPropertyDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ComplexCustomPropertyDto: Codable {

    var propertyClass: String?
    var value: ObjectValueDto?
    var parentCode: String?
    var itemViewType: String?
    var dictionaryDefinitionName: String?
    var required: Bool?
    var editable: Bool?
    var sequence: Int32?
    var groupDefinitionId: Int32?
    var groupInstanceId: Int32?
}
