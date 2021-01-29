//
//  LocationDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class LocationDto: Codable {
    
    var id: Int32?
    var city: String?
    var street: String?
    var buildingNo: String?
    var flatNo: String?
    var latitude: Double?
    var longitude: Double?
}

