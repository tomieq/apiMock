//
//  CountryDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class CountryListDto: Codable {
    var countries: [CountryDto]?
}


class CountryDto: Codable {
    var id: Int32?
    var name: String?
    var code: String?
    var administrationUnitDtoList: [AdministrationUnitDto]?
}
