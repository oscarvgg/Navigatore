//
//  Routes.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 03/02/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
import Sailor

enum Routes: String {
    case rootController
    
    case signin
    case signup
    
    case main // (tab bar controller)
    case tab1Root // navigation
    case tab1
    case tab11
    case tab2
    case tab3
    
    case modalRoot // (navigation controller)
    case modal1
    case modal11
}

extension Routes: Routable {
    
    var identifier: String {
        return self.rawValue
    }
    
    var viewControllerInitMethod: ViewControllerInitMethod {
        switch self {
        case .rootController:
            return .manual(viewController: NavigatorController.self)
            
        case .signin:
            return .storyboard(storyboardName: "Main", controllerId: "signIn")
        case .signup:
            return .storyboard(storyboardName: "Main", controllerId: "signUp")
            
        case .main:
            return .manual(viewController: NavigatorTabBarController.self)
        case .tab1Root:
            return .manual(viewController: NavigatorController.self)
        case .tab1:
            return .storyboard(storyboardName: "Main", controllerId: "tab1")
        case .tab11:
            return .storyboard(storyboardName: "Main", controllerId: "tab11")
        case .tab2:
            return .storyboard(storyboardName: "Main", controllerId: "tab2")
        case .tab3:
            return .storyboard(storyboardName: "Main", controllerId: "tab3")
            
        case .modalRoot:
            return .manual(viewController: NavigatorController.self)
        case .modal1:
            return .storyboard(storyboardName: "Main", controllerId: "modal1")
        case .modal11:
            return .storyboard(storyboardName: "Main", controllerId: "modal11")
        }
    }
    
    var navigationMethod: NavigationMethod {
        switch self {
        case .rootController:
            return .root
            
        case .signin:
            return .root
        case .signup:
            return .push(animated: true)
            
        case .main:
            return .root
        case .tab1Root:
            return .root
        case .tab1:
            return .root
        case .tab11:
            return .push(animated: true)
        case .tab2:
            return .root
        case .tab3:
            return .root
            
        case .modalRoot:
            return .modal(style: UIModalPresentationStyle.fullScreen,
                          rect: nil,
                          animated: true)
        case .modal1:
            return .root
        case .modal11:
            return .push(animated: true)
        }
    }
    
    var customInitializer: ((UIViewController) -> Void)? {
        switch self {
        case .rootController:
            return { (controller) in
                guard let navigator = controller as? NavigatorController else {
                    return
                }
                navigator.isNavigationBarHidden = true
            }
        case .tab1Root:
            return { (controller) in
                controller.title = "Tab 1"
            }
        case .tab1:
            return { (controller) in
                controller.title = "Tab 1"
            }
        default:
            return nil
        }
    }
}

extension Routes: PathProvider {
    
    static func pathForRoute(route: Routable) throws -> [Routable] {
        switch route {
        case Routes.rootController:
            return [Routes.rootController]
            
        case Routes.signin:
            return [Routes.rootController, Routes.signin]
        case Routes.signup:
            return [Routes.rootController, Routes.signup]
            
        case Routes.main:
            return [Routes.rootController, Routes.main]
        case Routes.tab1:
            return [Routes.rootController, Routes.main, Routes.tab1Root, Routes.tab1]
        case Routes.tab11:
            return [Routes.rootController, Routes.main, Routes.tab1Root, Routes.tab11]
        case Routes.tab2:
            return [Routes.rootController, Routes.main, Routes.tab2]
        case Routes.tab3:
            return [Routes.rootController, Routes.main, Routes.tab3]
            
        case Routes.modal1:
            return [Routes.rootController, Routes.modalRoot, Routes.modal1]
        case Routes.modal11:
            return [Routes.rootController, Routes.modalRoot, Routes.modal11]
            
        default:
            throw NavigationError.unsupportedRoute
        }
    }
}



