//
//  AuditFiltersDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class AuditFiltersDto: Codable {
    
    var sectionNames: [String]?
    var idsAndPredefinedAnswers: [String: [Int32]]?
}
