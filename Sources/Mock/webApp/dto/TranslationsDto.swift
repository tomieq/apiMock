//
//  TranslationsDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TranslationsDto: Codable {
    var locale: String?
    var translations: [String:String]?
}
