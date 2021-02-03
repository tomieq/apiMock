//
//  WorkOrderBasicDataDto.swift
//  
//
//  Created by Tomasz Kucharski on 03/02/2021.
//

import Foundation

class WorkOrderBasicDataDto: Codable {
    
    var workOrderId: Int32?
    var workOrderBusinessKey: String?
    var taskId: Int32?
    var taskBusinessKey: String?
}
