//
//  NetworkManager.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 26/12/2022.
//

import Foundation
import Combine

final class NetworkManager {
    static func download(url: URL) -> AnyPublisher<Data, Error> {
   return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else { throw URLError(.badServerResponse)}
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion:  Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
