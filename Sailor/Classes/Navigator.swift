//
//  Navigator.swift
//  Sailor
//
//  Created by Oscar Gonzalez on 15/12/2017.
//  Copyright © 2017 Sailor. All rights reserved.
//

import UIKit
import Foundation

public protocol Navigator {
    
    var ownRoute: Routable? { get set }
    var pathProvider: PathProvider.Type? { get set }
    var parentNavigator: Navigator? { get set }
    var childNavigators: [Navigator] { get set }
    var routes: [Routable] { get set }
    
    /// Navigates to the last route in the path
    ///
    /// - Parameters:
    ///   - segment: the segment to navigate to
    ///   - completion: the handler called when the navigation has been completed
    /// - Returns: true if the navigation was handled by the navigator itself of its children
    /// - Throws: if the navigation method is unsuported
    func navigate(to route: Routable, completion: (() -> Void)?) throws
    
    /// Performs a navigation to a route regardless of its path
    ///
    /// - Parameters:
    ///   - nextController: the view controller to navigate to
    ///   - method: the method to navigate with
    ///   - completion: the completion handler
    /// - Throws: if the navigation method is unsuported
    func display(route: Routable, completion: (() -> Void)?) throws
    
    /// Checks whether a navigator has navigated to a route
    ///
    /// - Parameter route: the route to check
    /// - Returns: the index of the route in the navigator, nil if not found
    func indexForChild(route: Routable) -> Int?
}

public extension Navigator {
    
    func navigate(navigator: Navigator, route: Routable, completion: (() -> Void)?) throws {
        guard let pathProvider = navigator.pathProvider else {
            throw NavigationError.pathProviderIsNil
        }
        var currentNavigator: Navigator? = navigator
        var path = try pathProvider.pathForRoute(route: route)
        let pathLastIndex = path.count - 1
        
        if pathLastIndex < 0 {
            throw NavigationError.pathMustHaveAtLeastTwoSegments
        }
        
        for index in 0..<pathLastIndex {
            let currentRoute = path[index]
            let nextRoute = path[index + 1]
            
            guard let navigatorRoute = currentNavigator?.ownRoute else {
                throw NavigationError.navigatorWithoutOwnRoute
            }
            if currentRoute.identifier != navigatorRoute.identifier {
                // this navigator cannot handle this path
                throw NavigationError.unableToHandlePath
            }
            try currentNavigator?.display(route: nextRoute, completion: nil)
            currentNavigator = currentNavigator?
                .childNavigators
                .filter({ (childNavigator) -> Bool in
                    nextRoute.identifier == childNavigator.ownRoute?.identifier
                }).first
        }
        completion?()
    }
    
    func navigate(to route: Routable, completion: (() -> Void)?) throws {
        try self.navigate(navigator: self,
                          route: route,
                          completion: completion)
    }
    
    func indexForChild(route: Routable) -> Int? {
        return routes.index { (childRoute) -> Bool in
            return route.identifier == childRoute.identifier
        }
    }
    
    static func instantiateViewController(route: Routable) -> UIViewController {
        var navigable: UIViewController!
        
        switch route.viewControllerInitMethod {
        case .storyboard(let storyboardName, let controllerId):
            let storyboard = UIStoryboard(name: storyboardName,
                                          bundle: Bundle.main)
            navigable = storyboard.instantiateViewController(
                withIdentifier: controllerId)
            
        case .nib(let nibName):
            navigable = UIViewController(nibName: nibName,
                                         bundle: Bundle.main)
            
        case .manual(let viewController):
            navigable = viewController.init(nibName: nil,
                                            bundle: nil)
            
        case .closure(let closure):
            navigable = closure()
        }
        if var navigator = navigable as? Navigator {
            navigator.ownRoute = route
        }
        route.customInitializer?(navigable)
        return navigable
    }
    
}
