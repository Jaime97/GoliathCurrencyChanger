//
//  ProductApi.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Moya

enum ProductApi {
    case productList
    case currencyConversions
}

extension ProductApi: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: DataConstants.productApiUrl) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .productList:
            return DataConstants.productListApiPath
        case .currencyConversions:
            return DataConstants.productRatesApiPath
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .productList, .currencyConversions:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [DataConstants.headerKey: DataConstants.mimeTypeJson]
    }
        
}
