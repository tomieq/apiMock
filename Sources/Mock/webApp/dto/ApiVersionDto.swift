//
//  ApiVersionDto.swift
//  
//
//  Created by Tomasz Kucharski on 27/01/2021.
//

import Foundation

enum ApiVersionStatus: String, Codable {
    case CURRENT
    case DEPRECATED
    case FORBIDDEN
}

class ApiVersionDto: Codable {
    
    var version: String?
    var status: ApiVersionStatus?
}
