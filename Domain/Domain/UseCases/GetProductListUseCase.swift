//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Jaime Alcántara on 17/09/2021.
//

import Foundation

public protocol GetProductListUseCaseProtocol {
    
    func execute(onListObtained:([String])->())
    
}

class GetProductListUseCase: GetProductListUseCaseProtocol {

    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    func execute(onListObtained: ([String]) -> ()) {
        onListObtained(data)
    }

}
