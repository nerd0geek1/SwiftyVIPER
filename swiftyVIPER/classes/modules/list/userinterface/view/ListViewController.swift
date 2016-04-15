//
//  ListViewController.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/15.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

protocol ListUserInterfaceType {
    func showNoContentView()
    func showContentView(contentList: [TodoViewableItem])
    func showErrorView(error: NSError)
}