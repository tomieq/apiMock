//
//  ComplexGroupDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ComplexGroupDto: Codable {
    
    var groupDefinitionId: Int32?
    var groupInstanceId: Int32?
    var groupName: String?
    var sequence: Int32?
    var complexGroupAttributes: [ComplexCustomPropertyDto]?
    var children: [ComplexGroupDto]?
    
}
