//
//  NetworkManager.swift
//  Cryptocurrency
//
//  Created by Ahmed Amin on 08/06/2023.
//

import Foundation
import Combine



final class NetworkManager {
    
    //MARK: - Error
    
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad response from URL: \(url)"
                
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
 
    //MARK: - Fetch data
    
    static func fetchData(with url: URL) -> AnyPublisher<Data, Error> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    //MARK: - Handle URL response
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            
            throw NetworkError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    //MARK: - Handle sin completion
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print(error.localizedDescription)
        default:
            break
        }
    }
}
