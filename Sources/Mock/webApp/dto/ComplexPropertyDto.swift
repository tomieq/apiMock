//
//  ComplexPropertyDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ComplexPropertyListDto: Codable {
    var list: [ComplexPropertyDto]?

    enum CodingKeys: String, CodingKey {
        case list = "complexPropertyListDto"
    }
}

class ComplexPropertyDto: Codable {
    
    var propertyDefinitionId: Int32?
    var propertyInstanceId: Int32?
    var complexColumnLabels: [String]?
    var rootGroup: ComplexGroupDto?
    var objectId: Int32?
    var propertyClass: String?

}
