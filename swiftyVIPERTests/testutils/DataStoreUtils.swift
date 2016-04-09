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

    private let filePath: String

    init(fileName: String) {
        filePath = NSTemporaryDirectory().stringByAppendingString("/\(fileName)")
    }

    func setupRealmFile() -> DataStoreRealm {
        return DataStoreRealm(path: filePath)
    }

    func tearDownRealmFile() {
        try! NSFileManager.defaultManager().removeItemAtPath(filePath)
    }

    func realm() -> Realm {
        return try! Realm(path: filePath)
    }

    func cleanupAllEntities() {
        let realm: Realm = self.realm()
        realm.beginWrite()
        realm.deleteAll()
        try! realm.commitWrite()
    }

    func saveFakeTodo(title: String, dueDate: NSDate) {
        try! realm().write {
            let todoItem: TodoRealmItem = TodoRealmItem()
            todoItem.setAttributes(title, dueDate: dueDate)
            realm().add(todoItem)
        }
    }
}