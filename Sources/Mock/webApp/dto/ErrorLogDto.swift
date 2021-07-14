//
//  ErrorLogDto.swift
//  
//
//  Created by Tomasz Kucharski on 16/02/2021.
//

import Foundation

class ErrorLogDto: Codable {
    var exceptionTime: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_exceptionTime)
        }
        set(newExceptionTime) {
            _exceptionTime = MobileApiDateTransform().transformToJSON(newExceptionTime)
        }
    }
    private var _exceptionTime: Double?
    var applicationVersion: String?
    var report: String?
    var label: String?
    
    enum CodingKeys: String, CodingKey {
        case _exceptionTime = "exceptionTime"
        case applicationVersion
        case report
        case label
    }
}
