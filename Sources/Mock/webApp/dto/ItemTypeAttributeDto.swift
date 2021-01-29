//
//  ItemTypeAttributeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class ItemTypeAttributeDto: Codable {
    
    var id: Int32?
    var name: String?
    var code: String?
    var dictionaryCode: String?
    var parentCode: String?
    var type: String?
    var showOnList: Bool?
    var required: Bool?
    var sequence: Int32?
    var barcodeScannable: Bool? = false
}
