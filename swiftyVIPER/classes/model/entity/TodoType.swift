//
//  TodoType.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/05.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

protocol TodoType {
    var title: String { get set }
    var dueDate: NSDate { get set }
}
