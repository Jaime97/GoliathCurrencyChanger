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
    var alertManager: AlertManager!
    private var productList:[String] = [String]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productTableView.dataSource = self
        self.productTableView.delegate = self
        self.productTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        self.noProductMessage.alpha = 0
    }
    
    @objc func onRefresh(_ sender: AnyObject) {
        self.presenter.onTableRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.onViewShowed()
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        let name = selectedCell?.textLabel?.text
        self.presenter.onProductSelected(name: name!)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = self.productList[indexPath.row]
        cell.selectionStyle = .none
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
    
    func showAlert(title:String, message:String, buttonTitle:String, handler: (() -> ())?) {
        self.alertManager.showAlert(title: title, message: message, buttonTitle: buttonTitle, viewController: self, handler: handler)
    }
    
    func addRefreshToTable(refreshMessage:String) {
        self.refreshControl.attributedTitle = NSAttributedString(string: refreshMessage)
        self.refreshControl.addTarget(self, action: #selector(self.onRefresh(_:)), for: .valueChanged)
        self.productTableView.addSubview(self.refreshControl)
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
}
