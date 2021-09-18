//
//  ProductDetailViewController.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productCodeLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    var presenter: ProductDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
