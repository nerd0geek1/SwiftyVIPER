//
//  NSDate+Addition.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/10.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

extension NSDate {
    class func today() -> NSDate {
        let dateString: String = "2016/04/05"
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        return dateFormatter.dateFromString(dateString)!
    }

    func addDays(dayCount: Int) -> NSDate {
        let daySeconds: Int = 60 * 60 * 24
        return dateByAddingTimeInterval(NSTimeInterval(daySeconds * dayCount))
    }
}
