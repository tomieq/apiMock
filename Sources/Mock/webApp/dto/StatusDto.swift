//
//  StatusDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class StatusListDto: Codable {
    var list: [StatusDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "statusListDto"
    }
}


enum StatusFlowType: String, Codable {
    case workOrder = "WORK_ORDER"
    case task = "TASK"
    case equipment = "EQUIPMENT"
    case service = "SERVICE"
    case material = "MATERIAL"
    case itemTransfer = "ITEM_TRANSFER"
    case otherItemType = "OTHER_ITEM_TYPE"
    case unknown = "UNKNOWN"
}

class StatusDto: Codable {
    var id: Int32?
    var name: String?
    var code: String?
    var workRelated: Bool?
    var statusFlowType: [StatusFlowType]?
}
