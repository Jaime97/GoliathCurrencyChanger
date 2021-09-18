//
//  ProductListViewController.swift
//  Presentation
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import UIKit

class ProductListViewController: UIViewController {

    let CellIdentifier = "ProductTableViewCell"
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var noProductMessage: UILabel!
    @IBOutlet weak var loadingProductsView: UIView!
    @IBOutlet weak var loadingProductsActivityIndicator: UIActivityIndicatorView!
    
    
    var presenter: ProductListPresenterProtocol!
    private var productList:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTableView.dataSource = self
        self.productTableView.delegate = self
        self.productTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        self.noProductMessage.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.onViewShowed()
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.onProductSelected()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = self.productList[indexPath.row]
        return cell
    }
}

extension ProductListViewController: ProductListViewProtocol {
    
    func showProductList(products: [String]) {
        self.productList = products
        self.productTableView.reloadData()
    }
    
    func showEmptyListMessage() {
        self.noProductMessage.alpha = 1
    }
    
    func setLoadingViewVisibility(visible:Bool) {
        visible ? (self.loadingProductsView.alpha = 1) : (self.loadingProductsView.alpha = 0)
        visible ? self.loadingProductsActivityIndicator.startAnimating() : self.loadingProductsActivityIndicator.stopAnimating()
    }
    
    func setProductListVisibility(visible:Bool) {
        visible ? (self.productTableView.alpha = 1) : (self.productTableView.alpha = 0)
    }
    
    func showAlert(title:String, message:String, buttonTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
}
