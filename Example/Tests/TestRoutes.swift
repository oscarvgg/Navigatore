//
//  TestRoutes.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Sailor

enum TestRoutes: String {
    case root
    case login
    case main
    case addNew
    case more
    case modal
}

extension TestRoutes: Routable {
    
    var identifier: String {
        return self.rawValue
    }
    
    var viewControllerInitMethod: ViewControllerInitMethod {
        switch self {
        case .root:
            return .manual(viewController: NavigatorController.self)
        default:
            return .manual(viewController: UIViewController.self)
        }
        
    }
    
    var navigationMethod: NavigationMethod {
        switch self {
        case .root:
            return .root
        case .login:
            return .root
        case .modal:
            return .modal(style: UIModalPresentationStyle.fullScreen,
                          rect: nil,
                          animated: false)
        default:
            return .push(animated: false)
        }
    }
    
    var customInitializer: ((UIViewController) -> Void)? {
        return nil
    }
}

extension TestRoutes: PathProvider {
    
    static func pathForRoute(route: Routable) throws -> [Routable] {
        switch route {
        case TestRoutes.root:
            return [TestRoutes.root]
        case TestRoutes.login:
            return [TestRoutes.root, TestRoutes.login]
        case TestRoutes.main:
            return [TestRoutes.root, TestRoutes.main]
        case TestRoutes.addNew:
            return [TestRoutes.root, TestRoutes.addNew]
        case TestRoutes.more:
            return [TestRoutes.root, TestRoutes.more]
        case TestRoutes.modal:
            return [TestRoutes.root, TestRoutes.modal]
        default:
            throw NavigationError.unsupportedRoute
        }
    }
    
    
}

