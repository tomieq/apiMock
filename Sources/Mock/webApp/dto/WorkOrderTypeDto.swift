//
//  WorkOrderTypeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class WorkOrderTypeListDto: Codable {
    var list: [WorkOrderTypeDto]?

    enum CodingKeys: String, CodingKey {
        case list = "workOrderTypes"
    }
}

class WorkOrderTypeDto: Codable {
    var id: Int32?
    var name: String?
    var code: String?
    
}
