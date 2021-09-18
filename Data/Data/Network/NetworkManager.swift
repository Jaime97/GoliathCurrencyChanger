//
//  NetworkManager.swift
//  Data
//
//  Created by Jaime Alcántara on 18/09/2021.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<ProductApi> { get }

    func fetchProducts(completion: @escaping (Result<[NetworkProduct], Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<ProductApi>(plugins: [NetworkLoggerPlugin()])

    func fetchProducts(completion: @escaping (Result<[NetworkProduct], Error>) -> ()) {
        self.request(target: .productList, completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: ProductApi, completion: @escaping (Result<T, Error>) -> ()) {
        self.provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
