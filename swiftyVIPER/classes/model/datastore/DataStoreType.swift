//
//  DataStoreType.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/05.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

protocol DataStoreType {
    func fetchTodoItems(predicate: NSPredicate?,
                        sortDescriptors: [GenericSortDescriptor],
                        completion: ((todoItems: [TodoType], error: NSError?) -> Void)?)
    func save(todoItem: TodoType, completion: (NSError? -> Void)?)
}

struct GenericSortDescriptor {
    let key: String
    let ascending: Bool

    init(key: String, ascending: Bool) {
        self.key       = key
        self.ascending = ascending
    }
}