//
//  SiteDto.swift
//  
//
//  Created by Tomasz Kucharski on 08/03/2021.
//

import Foundation

class SiteListDto: Codable {
    
    var sites: [SiteDto]?
    var resultCount: Int32?
    var pageCount: Int32?
}

class SiteDto: Codable {
    
    var id: Int32?
    var externalId: String?
    var name: String?
    var location: LocationDto?
    
}
