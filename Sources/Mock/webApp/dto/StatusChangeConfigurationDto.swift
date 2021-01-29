//
//  StatusChangeConfigurationDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class StatusChangeConfigurationListDto: Codable {
    var list: [StatusChangeConfigurationDto]?

    enum CodingKeys: String, CodingKey {
        case list = "statusChangeConfigurationList"
    }
}


class StatusChangeConfigurationDto: Codable {
    
    var objectTypeId: Int32?
    var statusFlowList: [StatusTransitionDto]?
}


class StatusTransitionDto: Codable {
    
    var firstStatusId: Int32?
    var nextStatusId: Int32?
    var noteRendered: Bool?
    var noteRequired: Bool?
    
}
