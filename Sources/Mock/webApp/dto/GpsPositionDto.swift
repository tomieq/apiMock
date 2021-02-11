//
//  GpsPositionDto.swift
//  
//
//  Created by Tomasz Kucharski on 11/02/2021.
//

import Foundation

class GpsPositionsDto: Codable {
    var positions: [GpsPositionDto]?
}

class GpsPositionDto: Codable {
    var longitude: Double?
    var latitude: Double?
    var accuracy: Double?
    var captureDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_captureDate)
        }
        set(newDate) {
            _captureDate = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    private var _captureDate: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case accuracy
        case _captureDate = "captureDate"
    }
}
