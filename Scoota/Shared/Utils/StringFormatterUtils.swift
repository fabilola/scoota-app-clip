//
//  StringFormatterUtils.swift
//  Scoota
//
//  Created by Dums, Fabiola on 30.01.23.
//

import Foundation

func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
     return (minutes / 60, (minutes % 60))
 }

func computeDurationString(minutes: Int) -> String {
        let tuple = minutesToHoursAndMinutes(minutes)
        return "\(String(format: "%02d", tuple.hours)):\(String(format: "%02d", tuple.leftMinutes))"
    }

func computeBatteryMinString(minutes: Int) -> String {
    let tuple = minutesToHoursAndMinutes(minutes)
    return "~" + String(tuple.hours) + "h " + String(tuple.leftMinutes) + "m"
}

func elapseString(timeInterval: TimeInterval) -> String {
   let formatter = DateComponentsFormatter()
          formatter.unitsStyle = .positional
          formatter.allowedUnits = [ .minute, .second ]
          formatter.zeroFormattingBehavior = [ .pad ]
          formatter.allowsFractionalUnits = true
   return formatter.string(from: timeInterval) ?? ""
}

func distanceString(distance: Double) -> String {
    return String(format: "%.1f km", distance)
}
