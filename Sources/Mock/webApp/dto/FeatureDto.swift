//
//  FeatureDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class FeatureListDto: Codable {
    var list: [FeatureDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "featureDtoList"
    }
}

class FeatureDto: Codable {
    var enabled: Bool?
    var code: String?
}

