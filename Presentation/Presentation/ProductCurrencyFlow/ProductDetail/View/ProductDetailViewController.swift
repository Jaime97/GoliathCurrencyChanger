//
//  ProductDetailViewController.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
