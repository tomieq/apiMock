//
//  SystemParameterDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class SystemParameterListDto: Codable {
    var list: [SystemParameterDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "systemParameters"
    }
}

class SystemParameterDto: Codable {
    var id: Int32?
    var name: String?
    var code: String?
    var type: String?
    
    var stringValue: String?
    var booleanValue: Bool?
    var intValue: Int32?
    var dateValue: UInt64?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case type
        case stringValue
        case booleanValue
        case intValue = "numberValue"
        case dateValue
    }
    
}

