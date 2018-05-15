//
//  ViewController.swift
//  Sailor
//
//  Created by oscarvgg on 02/03/2018.
//  Copyright (c) 2018 oscarvgg. All rights reserved.
//

import UIKit
import Sailor

class SignInViewController: UIViewController {
    
    @IBAction func didTapSignUp(_ sender: Any) {
        do {
            try navigator.navigate(to: Routes.signup,
                                   completion: nil)
        } catch let error {
            print(error)
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
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

