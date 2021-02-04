//
//  TransferTypeDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class TransferTypeListDto: Codable {
    var transferTypes: [TransferTypeDto]?
}

class TransferTypeDto: Codable {
    
    var id: Int32?
    var code: String?
    var name: String?
    var flowId: Int32?
    var customProperties: [CustomPropertyDto]?
}
