//
//  Date+extension.swift
//  
//
//  Created by Tomasz Kucharski on 02/02/2021.
//

import Foundation


extension Date {
    
    private func getCalendar() -> Calendar {
        return Calendar.current
    }
    
    func dateWithTime(hour: Int, minute: Int) -> Date? {
        guard hour >= 0 && hour <= 24 && minute >= 0 && minute <= 60 else { return nil}
        let calendar = self.getCalendar()
        var dateComponests = calendar.dateComponents([.day, .month, .year], from: self)
        dateComponests.hour = hour
        dateComponests.minute = minute
        return calendar.date(from: dateComponests)
    }
    
    func dateAdding(dayCount: Int) -> Date? {
        let calendar = self.getCalendar()
        return calendar.date(byAdding: .day, value: dayCount, to: self)
    }
    
    func dateAdding(monthCount: Int) -> Date? {
        let calendar = self.getCalendar()
        return calendar.date(byAdding: .month, value: monthCount, to: self)
    }
    
    func dateAdding(minuteCount: Int) -> Date? {
        let calendar = self.getCalendar()
        return calendar.date(byAdding: .minute, value: minuteCount, to: self)
    }
    
    func dateAdding(secondCount: Int) -> Date? {
        let calendar = self.getCalendar()
        return calendar.date(byAdding: .second, value: secondCount, to: self)
    }
}

extension Date {
    
    static func startOfDay(_ date: Date = Date()) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func endOfDay(_ date: Date = Date()) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay(date))!
    }
}
