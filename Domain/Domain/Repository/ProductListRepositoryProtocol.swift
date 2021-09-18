//
//  ProductRepositoryProtocol.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public protocol ProductRepositoryProtocol {
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> ())
    
    func findProductInProductList(productCode:String) -> Product?
    
}
