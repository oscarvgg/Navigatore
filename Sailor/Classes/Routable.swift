//
//  Routable.swift
//  Sailor
//
//  Created by Oscar Gonzalez on 03/02/2018.
//

import Foundation

public protocol Routable {
    var identifier: String { get }
    var viewControllerInitMethod: ViewControllerInitMethod { get }
    var navigationMethod: NavigationMethod { get }
    var customInitializer: ((UIViewController) -> Void)? { get}
}

public protocol PathProvider {
    static func pathForRoute(route: Routable) throws -> [Routable]
}

public enum NavigationMethod {
    case root
    case push(animated: Bool)
    case modal(style: UIModalPresentationStyle, rect: CGRect?, animated: Bool)
}

public enum ViewControllerInitMethod {
    case storyboard(storyboardName: String, controllerId: String)
    case nib(nibName: String)
    case manual(viewController: UIViewController.Type)
    case closure(closure: (() -> UIViewController))
}
