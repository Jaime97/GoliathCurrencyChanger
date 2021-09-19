//
//  ProductDetailViewController.swift
//  Presentation
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let CellIdentifier = "AmountTableViewCell"
    
    @IBOutlet weak var productCodeLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    @IBOutlet weak var loadingTransactionsView: UIView!
    
    @IBOutlet weak var loadingTranstactionsActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var TotalAmountActivityIndicator: UIActivityIndicatorView!
    
    
    var presenter: ProductDetailPresenterProtocol!
    var alertManager: AlertManager!

    var transactionList:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transactionTableView.dataSource = self
        self.transactionTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.onViewShowed()
    }

}

extension ProductDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = self.transactionList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    
    func showTransactionList(transactions: [String]) {
        self.transactionList = transactions
        self.transactionTableView.reloadData()
    }
    
    func addProductCodeToTitle(productCode: String) {
        self.productCodeLabel.text = productCode
    }
    
    func addTotalAmountForThisProduct(totalAmount: String) {
        self.totalAmountLabel.text = totalAmount
    }
    
    func setLoadingViewVisibility(visible:Bool) {
        visible ? (self.loadingTransactionsView.alpha = 1) : (self.loadingTransactionsView.alpha = 0)
        visible ? self.loadingTranstactionsActivityIndicator.startAnimating() : self.loadingTranstactionsActivityIndicator.stopAnimating()
    }
    
    func setTotalAmountActivityIndicatorVisibility(visible:Bool) {
        visible ? (self.TotalAmountActivityIndicator.alpha = 1) : (self.TotalAmountActivityIndicator.alpha = 0)
        visible ? self.TotalAmountActivityIndicator.startAnimating() : self.TotalAmountActivityIndicator.stopAnimating()
    }
    
    func showAlert(title:String, message:String, buttonTitle:String) {
        self.alertManager.showAlert(title: title, message: message, buttonTitle: buttonTitle, viewController: self)
    }
}
