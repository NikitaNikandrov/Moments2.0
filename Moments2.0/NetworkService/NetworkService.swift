//
//  NetworkService.swift
//  Moments2.0
//
//  Created by Nikita Nikandrov on 20.03.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func createRequest(sheme: String,
                       host: String,
                       path: String,
                       httpMethod: String,
                       queryItems: [URLQueryItem]?) throws -> URLRequest
    
    func sendRequest<T: Codable>(with request: URLRequest,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func createRequest(sheme: String,
                       host: String,
                       path: String,
                       httpMethod: String,
                       queryItems: [URLQueryItem]?) throws -> URLRequest {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = sheme
        urlComponent.host = host
        urlComponent.path = path
        
        if queryItems != [] {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else {
            throw NetworkServiceError.failedToCreateURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        return request
    }
    
    func sendRequest<T: Codable>(with request: URLRequest,
                                 type: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkServiceError.customError(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkServiceError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkServiceError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResult = try decoder.decode(T.self, from: data)
                completion(.success(decodedResult))
            } catch {
                completion(.failure(NetworkServiceError.DecodingFail(error: error)))
            }
            
        }.resume()
    }
    
}

extension NetworkService {
    
    enum NetworkServiceError: Error {
        case customError(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case DecodingFail(error: Error)
        case failedToCreateURL
    }
}
