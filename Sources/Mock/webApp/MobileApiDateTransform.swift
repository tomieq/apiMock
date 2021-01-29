//
//  MobileApiDateTransform.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class MobileApiDateTransform {
    
    public typealias Object = Date
    public typealias JSON = Double
    
    func transformFromJSON(_ value: Any?) -> Date? {
        guard let timestamp = value as? Double else {
            return nil
        }
        return Date(timeIntervalSince1970: TimeInterval(timestamp / 1000))
    }
    
    func transformToJSON(_ value: Date?) -> Double? {
        guard let date = value else{
            return nil
        }
        return Double(String(format: "%.f", date.timeIntervalSince1970 * 1000))
    }
}
