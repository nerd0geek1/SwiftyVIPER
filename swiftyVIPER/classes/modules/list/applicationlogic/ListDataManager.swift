//
//  ListDataManager.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import UIKit

class ListDataManager: DataManagerType {

    enum SortType: String {
        case Title   = "title"
        case DueDate = "dueDate"
    }

    private let dataStore: DataStoreType

    //MARK: - lifecycle

    required init(dataStore: DataStoreType) {
        self.dataStore = dataStore
    }

    //MARK: - public

    func fetchTodoItems(startDate: NSDate, endDate: NSDate, sortType: SortType, ascending: Bool, completion: (([TodoEntityItem], NSError?) -> Void)) {
        let predicate: NSPredicate = NSPredicate.init(format: "(dueDate <= %@) AND (%@ <= dueDate)", startDate, endDate)
        let sortDescriptor: GenericSortDescriptor = GenericSortDescriptor(key: sortType.rawValue, ascending: ascending)
        dataStore.fetchTodoItems(predicate, sortDescriptors: [sortDescriptor]) { (todoItems, error) in
            completion(todoItems, error)
        }
    }
}
