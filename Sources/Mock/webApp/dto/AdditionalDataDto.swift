//
//  AdditionalDataDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class AdditionalDataDto: Codable {
    var additionalAttributes: [CustomPropertyDto]?
    var isConfirmed: Bool?
    var agreeToTheSignature: Bool?
    var reasonRefusesToSignAnswerId: Int32?
    var note: String?
    var javaClass: String? = "com.comarch.fsm.fe.mobile.task.AdditionalDataDto"

    
    enum CodingKeys: String, CodingKey {
        case additionalAttributes
        case isConfirmed
        case agreeToTheSignature
        case reasonRefusesToSignAnswerId
        case note
        case javaClass = "@class"
    }
}

