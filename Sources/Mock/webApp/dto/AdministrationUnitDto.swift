//
//  AdministrationUnitDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class AdministrationUnitDto: Codable {
    var id: Int32?
    var parentId: Int32?
    var name: String?
    var levelCode: String?
    var levelLabel: String?
}
