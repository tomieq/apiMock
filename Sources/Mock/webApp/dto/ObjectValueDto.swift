//
//  ObjectValueDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ObjectValueDto: Codable {
    var code: String?
    var instanceId: Int32?
    var value: ItemValueDto?
}
