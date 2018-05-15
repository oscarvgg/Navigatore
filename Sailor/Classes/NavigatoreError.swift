//
//  SailorError.swift
//  Sailor
//
//  Created by Oscar Gonzalez on 03/02/2018.
//

import Foundation

public enum NavigationError: Error {
    
    case unsupportedNavigationMethod
    case unsupportedRoute
    case noMoreSegmentsToGoBack
    case pathMustHaveAtLeastTwoSegments
    case unableToHandlePath
    
    case pathProviderIsNil
    case navigatorWithoutOwnRoute
    case routeIsNotNavigator
}
