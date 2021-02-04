//
//  TransferDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class TransferListDto: Codable {
    var transferDtos: [TransferDto]?
}


class TransferDto: Codable {

    var id: Int32?
    var bussinesKey: String?
    var item: ItemDto?
    var quantity: Float?
    var sourceWarehouse: WarehouseDto?
    var destinationWarehouse: WarehouseDto?
    var statusId: Int32?
    var typeId: Int32?
    var createUser: UserDto?
    var transferRange: TimeRangeDto?
    var transitions: [TransferTransitionWithPropertiesDto]?
    
}

class TransferTransitionWithPropertiesDto: Codable {
    
    var transition: StatusTransitionDto?
    var attributes: TransferAdditionalAttributesListDto?
}

class TransferAdditionalAttributesListDto: Codable {
    var additionalAttributes: [TransferAdditionalAttributeDto]?
}

class TransferAdditionalAttributeDto: Codable {
    
    var id: Int32?
    var name: String?
    var code: String?
    var dictionaryCode: String?
    var parentCode: String?
    var type: String? //ItemValueDto.type
    var required: Bool?
    var sequence: Int32?
}
