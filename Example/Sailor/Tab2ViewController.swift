//
//  Tab2ViewController.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 10/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {

    @IBAction func didTapModal(_ sender: Any) {
        do {
            try navigator.navigate(to: Routes.modal1,
                                   completion: nil)
        } catch let error {
            print(error)
        }
    }
    
}
