//
//  AlertManager.swift
//  Presentation
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation
import UIKit

class AlertManager {
    
    func showAlert(title:String, message:String, buttonTitle:String, viewController:UIViewController, handler: (() -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler:{ _ in
            handler?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
