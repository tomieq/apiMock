//
//  TransferItemDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class TransferItemListDto: Codable {
    var transferItems: [TransferItemDto]?
}

class TransferItemDto: Codable {

    var itemId: Int32?
    var quantity: Float?
    var destinationWarehouseId: Int32?
}
