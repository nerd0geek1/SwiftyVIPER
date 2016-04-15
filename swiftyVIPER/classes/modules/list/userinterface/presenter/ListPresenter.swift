//
//  ListPresenter.swift
//  swiftyVIPER
//
//  Created by Kohei Tabata on 2016/04/15.
//  Copyright © 2016年 Kohei Tabata. All rights reserved.
//

import Foundation

protocol ListPresenterType: ListInteractorOutput {
    var listUserInterface: ListUserInterfaceType? { get set }
    var listInteractor: ListInteractorInput? { get set }
}