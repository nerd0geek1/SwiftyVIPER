//
//  DataStoreUtils.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/10.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation
import RealmSwift

@testable import swiftyVIPER

class DataStoreUtils {
    static private let filePath: String = NSTemporaryDirectory().stringByAppendingString("/test.realm")

    static func setupRealmFile() -> DataStoreRealm {
        return DataStoreRealm(path: filePath)
    }

    static func tearDownRealmFile() {
        try! NSFileManager.defaultManager().removeItemAtPath(filePath)
    }

    static func realm() -> Realm {
        return try! Realm(path: filePath)
    }

    static func cleanupAllEntities() {
        let realm: Realm = self.realm()
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }

    static func saveFakeTodo(title: String, dueDate: NSDate) {
        try! realm().write {
            let todoItem: TodoRealmItem = TodoRealmItem()
            todoItem.setAttributes(title, dueDate: dueDate)
            realm().add(todoItem)
        }
    }
}