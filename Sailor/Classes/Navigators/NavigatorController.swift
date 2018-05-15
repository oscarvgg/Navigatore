//
//  Navigator.swift
//  Sailor
//
//  Created by Oscar Gonzalez on 30/11/2017.
//  Copyright © 2017 Sailor. All rights reserved.
//

import UIKit

open class NavigatorController: UINavigationController, Navigator {
    
    open var ownRoute: Routable?
    open var pathProvider: PathProvider.Type?
    open var parentNavigator: Navigator?
    open var childNavigators: [Navigator] = []
    open var routes: [Routable] = []
    
    func moveForward(route: Routable, completion: (() -> Void)? = nil) {
        
        let nextController = NavigatorController.instantiateViewController(
            route: route)
        routes.append(route)
        
        if var nextNavigator = nextController as? Navigator {
            nextNavigator.parentNavigator = self
            nextNavigator.pathProvider = self.pathProvider
            childNavigators.append(nextNavigator)
        }
        
        switch route.navigationMethod {
        case .push(let animated):
            pushViewController(nextController,
                               animated: animated,
                               completion: completion)
            
        case .modal(let modalStyle, let sourceRect, let animated):
            modalPresentationStyle = modalStyle
            
            if let sourceRect = sourceRect, modalStyle == .popover {
                popoverPresentationController?.sourceRect = sourceRect
            }
            present(nextController,
                    animated: animated,
                    completion: completion)
            
        case .root:
            viewControllers = [nextController]
            completion?()
        }
    }
    
    open func display(route: Routable, completion: (() -> Void)?) throws {
        if let childIndex = indexForChild(route: route) {
            let reveseTimes = routes.count - childIndex - 1
            
            if reveseTimes <= 0 {
                return
            }
            
            for _ in 0..<reveseTimes {
                try reverse(completion: completion)
            }
            return
        }
        moveForward(route: route, completion: completion)
    }
    
    func reverse(completion: (() -> Void)? = nil) throws {
        guard let lastSegment = routes.last, routes.count > 1 else {
            throw NavigationError.noMoreSegmentsToGoBack
        }
        
        switch lastSegment.navigationMethod {
        case .push(let animated):
            if let completion = completion {
                _ = popViewController(animated: animated, completion: completion)
            } else {
                _ = popViewController(animated: animated)
            }
            // the route gets removed on pop view controller, don't have to do it here
        case .modal(_, _, let animated):
            dismiss(animated: animated, completion: completion)
            // remove the route
            routes = Array(routes.dropLast())
        case .root:
            throw NavigationError.noMoreSegmentsToGoBack
        }
        // remove child navigators that represend the removed route
        childNavigators = childNavigators.filter { (navigator) -> Bool in
            lastSegment.identifier != navigator.ownRoute?.identifier
        }
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        
        guard let coordinator = transitionCoordinator, animated else {
            completion?()
            return
        }
        coordinator.animate(alongsideTransition: nil) { (_) in
            completion?()
        }
    }
    
    override open func popViewController(animated: Bool) -> UIViewController? {
        let removed = routes.removeLast()
        // if it was a child navigator, remove it too
        childNavigators = childNavigators.filter { (navigator) -> Bool in
            removed.identifier != navigator.ownRoute?.identifier
        }
        return super.popViewController(animated: animated)
    }
    
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        _ = popViewController(animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(alongsideTransition: nil) { (_) in
            completion()
        }
    }
}
