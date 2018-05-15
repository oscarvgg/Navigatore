//
//  NavigatorControllerMock.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 15/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Sailor

class TabNavigatorControllerMock: NavigatorTabBarController {
    
    var calledPresent = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        calledPresent = true
        super.present(viewControllerToPresent,
                      animated: flag,
                      completion: completion)
    }
}
