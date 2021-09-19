//
//  Decimal+Round.swift
//  Domain
//
//  Created by Jaime Alcántara on 20/09/2021.
//

import Foundation

extension Decimal {
    
    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
