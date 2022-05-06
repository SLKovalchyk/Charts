//
//  XAxisNameFormater.swift
//  Chart
//
//  Created by Sergey on 06.05.2022.
//

import Foundation
import Charts

final class XAxisNameFormater: NSObject, AxisValueFormatter {
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
}
