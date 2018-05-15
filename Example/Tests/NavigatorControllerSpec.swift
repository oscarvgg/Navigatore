//
//  NavigatorControllerSpec.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 13/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Sailor

class NavigatorControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("A Navigator Controller") {
            
            context("Navigating backwards and forward") {
                
                let navigatorController = NavigatorController.instantiateViewController(
                    route: TestRoutes.root) as! NavigatorController
                navigatorController.pathProvider = TestRoutes.self
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = navigatorController
                window.isHidden = false
                
                beforeEach {
                    navigatorController.viewControllers = []
                    navigatorController.routes = []
                    navigatorController.parentNavigator = nil
                    navigatorController.childNavigators = []
                }
                
                it("Should Navigate forward") {
                    
                    expect {
                        try navigatorController.navigate(to: TestRoutes.login,
                                                         completion: nil)
                    }.notTo(throwError())
                    expect(navigatorController.viewControllers.count).to(equal(1))
                    expect(navigatorController.routes.first?.identifier)
                        .to(equal(TestRoutes.login.identifier))
                }
                
                it("Should go backwards") {
                    expect {
                        try navigatorController.navigate(to: TestRoutes.login,
                                                         completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TestRoutes.main,
                                                         completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TestRoutes.modal,
                                                         completion: nil)
                        }.notTo(throwError())

                    expect(navigatorController.viewControllers.count).to(equal(2))
                    expect(navigatorController.routes.first?.identifier)
                        .to(equal(TestRoutes.login.identifier))
                    expect(navigatorController.routes[1].identifier)
                        .to(equal(TestRoutes.main.identifier))
                    expect(navigatorController.routes[2].identifier)
                        .to(equal(TestRoutes.modal.identifier))
                    
                    expect {
                        try navigatorController.navigate(to: TestRoutes.login,
                                                         completion: nil)
                        }.notTo(throwError())
                    expect(navigatorController.viewControllers.count).to(equal(1))
                    expect(navigatorController.routes.first?.identifier)
                        .to(equal(TestRoutes.login.identifier))
                }
                
                it("Should present modal") {
                    expect {
                        try navigatorController.navigate(to: TestRoutes.login,
                                                         completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TestRoutes.modal,
                                                         completion: nil)
                        }.notTo(throwError())
                    
                    expect(navigatorController.viewControllers.count).to(equal(1))
                    expect(navigatorController.routes.count).to(equal(2))
                }
            }
        }
    }
}
