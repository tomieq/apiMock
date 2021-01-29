//
//  PriorityDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class PriorityListDto: Codable {
    var list: [PriorityDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "priorityListDto"
    }
}


class PriorityDto: Codable {
    
    var id: Int32?
    var value: Int32?
    var color: String?
    var name: String?
}
