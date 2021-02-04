//
//  WarehouseDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class WarehouseListDto: Codable {
    var warehouseList: [WarehouseDto]?
}

class WarehouseDto: Codable {
    
    var id: Int32?
    var name: String?
    var owner: String?
    var type: String?
}
