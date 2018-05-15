//
//  SignUpViewController.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 10/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Sailor

class SignUpViewController: UIViewController {
    
    @IBAction func didTapSignUp(_ sender: Any) {
        do {
            try navigator.navigate(to: Routes.tab1,
                                   completion: nil)
            try navigator.navigate(to: Routes.tab2,
                                   completion: nil)
            try navigator.navigate(to: Routes.tab3,
                                   completion: nil)
        } catch let error {
            print(error)
        }
    }
    
}
