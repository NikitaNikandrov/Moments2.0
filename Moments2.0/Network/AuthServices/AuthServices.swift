//
//  AuthServices.swift
//  Moments2.0
//
//  Created by Nikita Nikandrov on 23.03.2024.
//

import Foundation

class AuthServices {
    
    private let nwService: NetworkServiceProtocol
    
    init(nwService: NetworkServiceProtocol) {
        self.nwService = nwService
    }
    
    func sendLoginRequest(dataForLogin: LoginRequestModel,
                          completion: @escaping(Result<AuthResponseModel, Error>) -> Void) {
        
        let path = "/login"
        let queryItems = [URLQueryItem(name: "email", value: "\(dataForLogin.email)"),
                          URLQueryItem(name: "password", value: "\(dataForLogin.password)")]
        
        
        do {
            
            let request = try nwService.createRequest(sheme: MomentsApiData.sheme,
                                                      host: MomentsApiData.host,
                                                      path: path,
                                                      httpMethod: HTTPMethods.post,
                                                      queryItems: queryItems)
            
            nwService.sendRequest(with: request, type: AuthResponseModel.self) { result in
                completion(result)
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func sendRegistrationRequest(dataForRegistration: RegistrationRequestModel,
                         completion: @escaping(Result<AuthResponseModel, Error>) -> Void) {
        
        let path = "/registration"
        let queryItems = [URLQueryItem(name: "name", value: "\(dataForRegistration.name)"),
                          URLQueryItem(name: "email", value: "\(dataForRegistration.email)"),
                          URLQueryItem(name: "password", value: "\(dataForRegistration.password)")]
        
        do {
            
            let request = try nwService.createRequest(sheme: MomentsApiData.sheme,
                                                      host: MomentsApiData.host,
                                                      path: path,
                                                      httpMethod: HTTPMethods.post,
                                                      queryItems: queryItems)
            
            nwService.sendRequest(with: request, type: AuthResponseModel.self) { result in
                completion(result)
            }
        } catch {
            completion(.failure(error))
        }
    }
}
