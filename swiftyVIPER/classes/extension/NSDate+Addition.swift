//
//  NSDate+Addition.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

extension NSDate {
    func addDays(days: Int) -> NSDate {
        let oneDaySeconds: Int = 60 * 60 * 24
        return self.dateByAddingTimeInterval(NSTimeInterval(oneDaySeconds * days))
    }
}
