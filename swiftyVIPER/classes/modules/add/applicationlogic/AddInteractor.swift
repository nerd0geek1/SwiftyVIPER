//
//  AddInteractor.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

struct AddInteractor {

    private let dataManager: AddDataManager

    //MARK: - lifecycle

    init(dataManager: AddDataManager) {
        self.dataManager = dataManager
    }

    //MARK: - public

    func addTodo(title: String, dueDate: NSDate, completion: (NSError? -> Void)?) {
        dataManager.addTodo(title, dueDate: dueDate, completion: completion)
    }
}
