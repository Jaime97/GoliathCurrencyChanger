//
//  String+Decimal.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Foundation

extension String {
    func toDecimal() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.number(from: self.description) as? Decimal
    }
}
