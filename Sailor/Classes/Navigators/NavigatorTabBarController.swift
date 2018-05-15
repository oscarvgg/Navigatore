//
//  TabBarController.swift
//  Sailor
//
//  Created by Oscar Gonzalez on 15/12/2017.
//  Copyright © 2017 Sailor. All rights reserved.
//

import UIKit

open class NavigatorTabBarController: UITabBarController, Navigator {
    
    open var ownRoute: Routable?
    open var pathProvider: PathProvider.Type?
    open var parentNavigator: Navigator?
    open var childNavigators: [Navigator] = []
    open var routes: [Routable] = []
    
    open func display(route: Routable, completion: (() -> Void)?) throws {
        let nextController = NavigatorController.instantiateViewController(
            route: route)
        
        switch route.navigationMethod {
        case .push:
            throw NavigationError.unsupportedNavigationMethod
            
        case .modal(let modalStyle, let sourceRect, let animated):
            modalPresentationStyle = modalStyle
            
            if let sourceRect = sourceRect, modalStyle == .popover {
                popoverPresentationController?.sourceRect = sourceRect
            }
            routes.append(route)
            
            if var nextNavigator = nextController as? Navigator {
                nextNavigator.parentNavigator = self
                nextNavigator.pathProvider = self.pathProvider
                childNavigators.append(nextNavigator)
            }
            present(nextController,
                    animated: animated,
                    completion: completion)
            
        case .root:
            if let childIndex = indexForChild(route: route) {
                selectedIndex = childIndex
                completion?()
                return
            }
            var newViewControllers = viewControllers ?? []
            newViewControllers.append(nextController)
            viewControllers = newViewControllers
            routes.append(route)
            
            let lastIndex = viewControllers!.count - 1
            tabBar.items?[lastIndex].title = nextController.title
            
            if var nextNavigator = nextController as? Navigator {
                nextNavigator.parentNavigator = self
                nextNavigator.pathProvider = self.pathProvider
                childNavigators.append(nextNavigator)
            }
            
            completion?()
        }
    }
}
