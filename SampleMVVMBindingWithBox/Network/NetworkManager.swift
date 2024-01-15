//
//  NetworkManager.swift
//  SampleMVVMBindingWithBox
//
//  Created by Suresh Sindam on 1/14/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

protocol NetworkManaging {
    func getUsers(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class NetworkManager: NetworkManaging {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getUsers(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.requestFailed(error!)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
