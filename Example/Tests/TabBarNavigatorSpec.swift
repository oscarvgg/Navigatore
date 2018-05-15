//
//  TabBarNavigatorSpec.swift
//  Sailor_Tests
//
//  Created by Oscar Gonzalez on 23/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Sailor

class TabBarNavigatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("A tab bar navigator controller") {
            
            context("Adding initial tabs") {
                let navigatorController = NavigatorController.instantiateViewController(
                    route: TabRoutes.root) as! TabNavigatorControllerMock
                navigatorController.pathProvider = TabRoutes.self
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = navigatorController
                window.isHidden = false
                
                beforeEach {
                    navigatorController.viewControllers = []
                    navigatorController.routes = []
                    navigatorController.parentNavigator = nil
                    navigatorController.childNavigators = []
                }
                
                it("Should add 4 tabs") {
                    
                    expect {
                        try navigatorController.navigate(to: TabRoutes.tabOne, completion: nil)
                    }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TabRoutes.TabTwo, completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TabRoutes.TabThree, completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TabRoutes.TabFour, completion: nil)
                        }.notTo(throwError())
                    expect(navigatorController.childNavigators.count).to(equal(0))
                    expect(navigatorController.routes.count).to(equal(4))
                    expect(navigatorController.viewControllers?.count).to(equal(4))
                }
                
                it("Should present a modal view") {
                    expect {
                        try navigatorController.navigate(to: TabRoutes.tabOne, completion: nil)
                        }.notTo(throwError())
                    expect {
                        try navigatorController.navigate(to: TabRoutes.modal,
                                                         completion: nil)
                        }.notTo(throwError())
                    
                    expect(navigatorController.calledPresent)
                        .to(beTrue())
                    expect(navigatorController.viewControllers?.count)
                        .to(equal(1))
                    expect(navigatorController.routes.count)
                        .to(equal(2))
                }
            }
        }
    }
}
