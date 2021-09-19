//
//  AlertManager.swift
//  Presentation
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation
import UIKit

class AlertManager {
    
    func showAlert(title:String, message:String, buttonTitle:String, viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler:nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
