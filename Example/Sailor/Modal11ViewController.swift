//
//  Modal11ViewController.swift
//  Sailor_Example
//
//  Created by Oscar Gonzalez on 10/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class Modal11ViewController: UIViewController {

    @IBAction func didTapDismiss(_ sender: Any) {
        do {
            try navigator.navigate(to: Routes.main,
                                   completion: nil)
        } catch let error {
            print(error)
        }
    }
    
}
