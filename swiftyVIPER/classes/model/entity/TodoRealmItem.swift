//
//  TodoRealmItem.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/05.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation
import RealmSwift

class TodoRealmItem: Object {

    dynamic var title: String   = ""
    dynamic var dueDate: NSDate = NSDate()

    func setAttributes(title: String, dueDate: NSDate) {
        self.title   = title
        self.dueDate = dueDate
    }
}
