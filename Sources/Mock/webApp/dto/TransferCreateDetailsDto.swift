//
//  TransferCreateDetailsDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class TransferCreateDetailsListDto: Codable {
    var transferCreateDetailsDtos: [TransferCreateDetailsDto]?
}

class TransferCreateDetailsDto: Codable {

    var transferItemDto: TransferItemDto?
    var status: TransferCreateStatus?
    var transferId: Int32?
    var errorMessage: String?
}

enum TransferCreateStatus: String, Codable {
    case success = "SUCCESS"
    case validationError = "VALIDATION_ERROR"
    case executionError = "EXECUTION_ERROR"
    case unknown = "UNKNOWN"
    
}
