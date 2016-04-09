//
//  ListInteractorIO.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
    func findTodoItems()
}

protocol ListInteractorOutput {
    func foundTodoItems(todoItems: [TodoViewableItem])
    func failedToFindTodoItems(error: NSError)
}

struct TodoViewableItem {
    let title: String
    let dueDate: NSDate

    init(title: String, dueDate: NSDate) {
        self.title   = title
        self.dueDate = dueDate
    }
}