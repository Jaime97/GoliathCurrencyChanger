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
    
    var presenter: ProductListPresenterProtocol!
    private var productList:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTableView.dataSource = self
        self.productTableView.delegate = self
        self.productTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        self.noProductMessage.alpha = 0
        self.presenter.onViewLoaded()
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
}
