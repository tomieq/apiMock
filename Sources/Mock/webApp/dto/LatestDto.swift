//
//  LatestDto.swift
//  
//
//  Created by Tomasz Kucharski on 27/01/2021.
//

class LatestDto: Codable {
    
    var id: Int32?
    var version: String?
    var size: Int32?
    var supportedApiVersions: [ApiVersionDto]?
}
