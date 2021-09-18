//
//  ProductListRepositoryProtocol.swift
//  Domain
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

public protocol ProductListRepositoryProtocol {
    
    func getProductList(completion: @escaping (Result<[Product], Error>) -> ())
    
}
