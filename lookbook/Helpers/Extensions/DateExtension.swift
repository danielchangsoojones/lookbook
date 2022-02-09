//
//  DateExtension.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import Foundation
import Timepiece

extension Date {
    func format() -> String {
        if self > Date.today() {
            return formatAsClockTime()
        } else {
            return formatAsMultipleDayTime()
        }
    }
    
    private func formatAsClockTime() -> String {
        return createStringDate(from: "h:mm a")
    }
    
    private func formatAsMultipleDayTime() -> String {
        let dayDifference = getDayDifference()
        let stringDate = createStringDate(from: "h:mm a")
        if dayDifference < 7 {
            let dayOfWeek = self.dayOfWeek()
            return dayOfWeek + " " + stringDate
        } else {
            //need to convert dayDifference to an actual date e.g. Mar. 27th
            let monthAndDate = createStringDate(from: "MMM dd")
            return monthAndDate + ", " + stringDate
        }
    }
    
    private func getDayDifference() -> Int {
        let calendar = NSCalendar.current
        let now = Date()
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: now)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    private func createStringDate(from format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    private func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self).capitalized
    }
}
