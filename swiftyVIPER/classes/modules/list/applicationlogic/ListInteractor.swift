//
//  ListInteractor.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/06.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

struct ListInteractor: ListInteractorInput {

    var startDate: NSDate = NSDate()
    var duration: Int     = 14
    var output: ListInteractorOutput?

    private let dataManager: ListDataManager

    //MARK: - lifecycle

    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }

    func findTodoItems() {
        let endDate: NSDate = startDate.addDays(duration)

        dataManager.fetchTodoItems(startDate, endDate: endDate, sortType: .DueDate, ascending: true) {(todoItems, error) in
            if let error = error {
                self.output?.failedToFindTodoItems(error)
                return
            }

            let viewableTodoItems: [TodoViewableItem] = self.viewableItems(todoItems)
            self.output?.foundTodoItems(viewableTodoItems)

        }
    }

    //MARK: - private

    private func viewableItems(todoPlainItems: [TodoEntityItem]) -> [TodoViewableItem] {
        return todoPlainItems.map({ TodoViewableItem(title: $0.title, dueDate: $0.dueDate) })
    }
}
