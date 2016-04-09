//
//  AddDataManager.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import UIKit

class AddDataManager: DataManagerType {

    private let dataStore: DataStoreType

    //MARK: - lifecycle

    required init(dataStore: DataStoreType) {
        self.dataStore = dataStore
    }

    //MARK: - public

    func addTodo(title: String, dueDate: NSDate, completion: (NSError? -> Void)?) {
        let todoItem: TodoEntityItem = TodoEntityItem(title: title, dueDate: dueDate)
        dataStore.save(todoItem, completion: completion)
    }
}
