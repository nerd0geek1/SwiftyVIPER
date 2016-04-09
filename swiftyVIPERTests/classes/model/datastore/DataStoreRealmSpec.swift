//
//  DataStoreRealmSpec.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/05.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Quick
import Nimble

@testable import swiftyVIPER

class DataStoreRealmSpec: QuickSpec {

    var dataStoreUtils = DataStoreUtils(fileName: "DataStoreRealmSpec.realm")
    var dataStore: DataStoreRealm!

    override func spec() {
        beforeSuite {
            self.dataStore = self.dataStoreUtils.setupRealmFile()
        }
        afterSuite {
            self.dataStoreUtils.tearDownRealmFile()
        }
        describe("DataStoreRealm") {
            describe("fetchTodoItems:", closure: {
                beforeEach({
                    self.dataStoreUtils.cleanupAllEntities()
                })

                context("fetch items without saved items", closure: {
                    it("returns no items", closure: {
                        let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "title", ascending: true)]

                        self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                            expect{ todoItems.count }.toEventually(equal(0))
                        })
                    })
                })

                context("fetch items without predicate", closure: {
                    it("returns all items", closure: {
                        self.dataStoreUtils.saveFakeTodo("task1", dueDate: NSDate.today())
                        self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(1))
                        self.dataStoreUtils.saveFakeTodo("task3", dueDate: NSDate.today().addDays(2))

                        let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "title", ascending: true)]

                        self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                            expect{ todoItems.count }.toEventually(equal(3))
                        })
                    })
                })

                context("fetch items with predicate", closure: {
                    it("returns filtered items", closure: {
                        self.dataStoreUtils.saveFakeTodo("taskToday1", dueDate: NSDate.today())
                        self.dataStoreUtils.saveFakeTodo("taskToday2", dueDate: NSDate.today())
                        self.dataStoreUtils.saveFakeTodo("taskToday3", dueDate: NSDate.today())
                        self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(1))
                        self.dataStoreUtils.saveFakeTodo("task3", dueDate: NSDate.today().addDays(2))

                        let predicate: NSPredicate                   = NSPredicate.init(format: "dueDate == %@", NSDate.today())
                        let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "title", ascending: true)]

                        self.dataStore.fetchTodoItems(predicate, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                            expect{ todoItems.count }.toEventually(equal(3))
                            expect{ todoItems[0].dueDate }.toEventually(equal(NSDate.today()))
                            expect{ todoItems[1].dueDate }.toEventually(equal(NSDate.today()))
                            expect{ todoItems[2].dueDate }.toEventually(equal(NSDate.today()))
                        })
                    })
                })

                context("fetch items with title sorting", closure: {
                    context("ascending case", closure: {
                        it("returns title ascending order", closure: {
                            self.dataStoreUtils.saveFakeTodo("taskToday1", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("taskToday2", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("taskToday3", dueDate: NSDate.today())

                            let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "title", ascending: true)]

                            self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                                expect{ todoItems.count }.toEventually(equal(3))
                                expect{ todoItems[0].title }.toEventually(equal("taskToday1"))
                                expect{ todoItems[1].title }.toEventually(equal("taskToday2"))
                                expect{ todoItems[2].title }.toEventually(equal("taskToday3"))
                            })
                        })
                    })
                    context("descending case", closure: {
                        it("returns title ascending order", closure: {
                            self.dataStoreUtils.saveFakeTodo("taskToday1", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("taskToday2", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("taskToday3", dueDate: NSDate.today())

                            let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "title", ascending: false)]

                            self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                                expect{ todoItems.count }.toEventually(equal(3))
                                expect{ todoItems[0].title }.toEventually(equal("taskToday3"))
                                expect{ todoItems[1].title }.toEventually(equal("taskToday2"))
                                expect{ todoItems[2].title }.toEventually(equal("taskToday1"))
                            })
                        })
                    })
                })

                context("fetch items with dueDate sorting", closure: {
                    context("ascending case", closure: {
                        it("returns dueDate ascending order", closure: {
                            self.dataStoreUtils.saveFakeTodo("task1", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(1))
                            self.dataStoreUtils.saveFakeTodo("task3", dueDate: NSDate.today().addDays(2))

                            let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "dueDate", ascending: true)]

                            self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                                expect{ todoItems.count }.toEventually(equal(3))
                                expect{ todoItems[0].dueDate }.toEventually(equal(NSDate.today()))
                                expect{ todoItems[1].dueDate }.toEventually(equal(NSDate.today().addDays(1)))
                                expect{ todoItems[2].dueDate }.toEventually(equal(NSDate.today().addDays(2)))
                            })
                        })
                    })
                    context("descending case", closure: {
                        it("returns dueDate ascending order", closure: {
                            self.dataStoreUtils.saveFakeTodo("task1", dueDate: NSDate.today())
                            self.dataStoreUtils.saveFakeTodo("task2", dueDate: NSDate.today().addDays(1))
                            self.dataStoreUtils.saveFakeTodo("task3", dueDate: NSDate.today().addDays(2))

                            let sortDescriptors: [GenericSortDescriptor] = [GenericSortDescriptor(key: "dueDate", ascending: false)]

                            self.dataStore.fetchTodoItems(nil, sortDescriptors: sortDescriptors, completion: { (todoItems, error) in
                                expect{ todoItems.count }.toEventually(equal(3))
                                expect{ todoItems[0].dueDate }.toEventually(equal(NSDate.today().addDays(2)))
                                expect{ todoItems[1].dueDate }.toEventually(equal(NSDate.today().addDays(1)))
                                expect{ todoItems[2].dueDate }.toEventually(equal(NSDate.today()))
                            })
                        })
                    })
                })
            })
            describe("save", closure: {
                beforeEach({
                    self.dataStoreUtils.cleanupAllEntities()
                })
                it("increase saved entity count", closure: {

                    let todoItem: TodoEntityItem = TodoEntityItem(title: "title1", dueDate: NSDate.today())
                    self.dataStore.save(todoItem) { (error) in
                        expect{ error }.toEventually(beNil())
                        expect{ self.dataStoreUtils.realm().objects(TodoRealmItem).count }.toEventually(equal(1))

                        let todoItem: TodoRealmItem = self.dataStoreUtils.realm().objects(TodoRealmItem).first!
                        expect{ todoItem.title }.toEventually(equal("title1"))
                        expect{ todoItem.dueDate }.toEventually(equal(NSDate.today()))
                    }
                })
            })
        }
    }
}
