//
//  Tab1ViewController.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 10/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Tab1ViewController: UIViewController {
    
    @IBAction func didTapForward(_ sender: Any) {
        do {
            try navigator.navigate(to: Routes.tab11,
                                   completion: nil)
        } catch let error {
            print(error)
        }
    }
    
}
