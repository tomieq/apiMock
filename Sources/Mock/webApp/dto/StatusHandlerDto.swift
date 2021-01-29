//
//  StatusHandlerDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class StatusHandlerListDto: Codable {
    var list: [StatusHandlerDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "statusHandlers"
    }
}

class StatusHandlerDto: Codable {
    
    var id: Int32?
    var code: String?
    var flowId: Int32?
    var statusId: Int32?
    
}
