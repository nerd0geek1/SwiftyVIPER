//
//  ListInteractorSpec.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/10.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Quick
import Nimble

@testable import swiftyVIPER

class ListInteractorSpec: QuickSpec {

    var dataStoreUtils: DataStoreUtils = DataStoreUtils(fileName: "ListInteractorSpec.realm")
    var interactor: ListInteractor!
    var output: ListInteractorOutputMock!

    override func spec() {
        beforeSuite {
            let dataStore: DataStoreRealm    = self.dataStoreUtils.setupRealmFile()
            let dataManager: ListDataManager = ListDataManager(dataStore: dataStore)
            self.interactor           = ListInteractor(dataManager: dataManager)
            self.interactor.startDate = NSDate.today()
            self.output               = ListInteractorOutputMock()
            self.interactor.output    = self.output
        }
        afterSuite { 
            self.dataStoreUtils.tearDownRealmFile()
        }

        describe("ListInteractor") {
            beforeEach({
                self.dataStoreUtils.cleanupAllEntities()
                self.output.todoItems = []
            })
            context("fetch items without saved items", {
                it("returns no items", closure: {
                    self.interactor.findTodoItems()

                    expect{ self.output.todoItems.isEmpty }.to(beTrue())
                })
            })

            context("fetch items with saved items which are all in range", {
                it("returns all items", closure: {
                    self.dataStoreUtils.saveFakeTodo("task1", dueDate: NSDate.today())
                    self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(13))

                    self.interactor.findTodoItems()

                    expect{ self.output.todoItems.count }.to(equal(2))
                    expect{ self.output.todoItems[0].dueDate }.to(equal(NSDate.today()))
                    expect{ self.output.todoItems[1].dueDate }.to(equal(NSDate.today().addDays(13)))
                })
            })

            context("fetch items with saved items which are in range and out of range.", {
                it("returns only in range items", closure: {
                    self.dataStoreUtils.saveFakeTodo("task0", dueDate: NSDate.today().addDays(-1))
                    self.dataStoreUtils.saveFakeTodo("task1", dueDate: NSDate.today())
                    self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(13))
                    self.dataStoreUtils.saveFakeTodo("task3", dueDate: NSDate.today().addDays(14))

                    self.interactor.findTodoItems()

                    expect{ self.output.todoItems.count }.to(equal(2))
                    expect{ self.output.todoItems[0].dueDate }.to(equal(NSDate.today()))
                    expect{ self.output.todoItems[1].dueDate }.to(equal(NSDate.today().addDays(13)))
                })
            })
        }
    }

    class ListInteractorOutputMock: ListInteractorOutput {
        var todoItems: [TodoViewableItem] = []

        func foundTodoItems(todoItems: [TodoViewableItem]) {
            self.todoItems = todoItems
        }

        func failedToFindTodoItems(error: NSError) {
            fatalError()
        }
    }
}
