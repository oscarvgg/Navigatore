//
//  TabRoutes.swift
//  Sailor_Tests
//
//  Created by Oscar Gonzalez on 23/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Sailor

enum TabRoutes: String {
    case root
    case tabOne
    case TabTwo
    case TabThree
    case TabFour
    case modal
}

extension TabRoutes: Routable {
    
    var identifier: String {
        return self.rawValue
    }
    
    var viewControllerInitMethod: ViewControllerInitMethod {
        switch self {
        case .root:
            return .manual(viewController: TabNavigatorControllerMock.self)
        default:
            return .manual(viewController: UIViewController.self)
        }
        
    }
    
    var navigationMethod: NavigationMethod {
        switch self {
        case .modal:
            return .modal(style: UIModalPresentationStyle.fullScreen,
                          rect: nil,
                          animated: false)
        default:
            return .root
        }
    }
    
    var customInitializer: ((UIViewController) -> Void)? {
        return nil
    }
}

extension TabRoutes: PathProvider {
    
    static func pathForRoute(route: Routable) throws -> [Routable] {
        guard let routes = route as? TabRoutes else {
            throw NavigationError.unsupportedRoute
        }
        switch routes {
        case .root:
            return [TabRoutes.root]
        case .tabOne:
            return [TabRoutes.root, TabRoutes.tabOne]
        case .TabTwo:
            return [TabRoutes.root, TabRoutes.TabTwo]
        case .TabThree:
            return [TabRoutes.root, TabRoutes.TabThree]
        case .TabFour:
            return [TabRoutes.root, TabRoutes.TabFour]
        case .modal:
            return [TabRoutes.root, TabRoutes.modal]
        }
    }
    
    
}
