//
//  DataStoreRealm.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/05.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation
import RealmSwift

class DataStoreRealm: DataStoreType {

    let path: String?
    private var realm: Realm?

    init(path: String? = nil) {
        self.path = path

        do {
            if let path = path {
                self.realm = try Realm(path: path)
            } else {
                self.realm = try Realm()
            }
        } catch let error as NSError {
            print("error:\(error)")
        }
    }

    func fetchTodoItems(predicate: NSPredicate?,
                        sortDescriptors: [GenericSortDescriptor],
                        completion: ((todoItems: [TodoType], error: NSError?) -> Void)?) {
        var results: Results<TodoRealmItem>? = realm?.objects(TodoRealmItem)


        if let predicate = predicate {
            results = results?.filter(predicate)
        }

        if let genericSortDescriptor: GenericSortDescriptor = sortDescriptors.first {
            let sortDescriptor: SortDescriptor = SortDescriptor(property: genericSortDescriptor.key,
                                                                ascending: genericSortDescriptor.ascending)
            results = results?.sorted([sortDescriptor])
        }

        let todoItems: [TodoType]
        if let results = results {
            todoItems = results.map({ $0 }).map({ TodoEntityItem(title: $0.title, dueDate: $0.dueDate) })
        } else {
            todoItems = []
        }

        completion?(todoItems: todoItems, error: nil)
    }

    func save(todoItem: TodoType, completion: (NSError? -> Void)?) {
        let todoRealmItem: TodoRealmItem = TodoRealmItem()
        todoRealmItem.setAttributes(todoItem.title, dueDate: todoItem.dueDate)

        do {
            try realm?.write({
                realm?.add(todoRealmItem)
                completion?(nil)
            })
        } catch let error as NSError {
            completion?(error)
        }
    }
}