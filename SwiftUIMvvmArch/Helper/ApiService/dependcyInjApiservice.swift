//
//  dependcyInjApiservice.swift
//  SwiftUIMvvmArch
//
//  Created by John on 08/04/24.
//

import Foundation
import Alamofire
import Combine

protocol NetworkService {
    func fetchData<T: Decodable>(url: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: JsonSerilizer?, objectType: T.Type) -> AnyPublisher<T, Error>
}


class NetworkManager: NetworkService {
    func fetchData<T>(url: URL, method: Alamofire.HTTPMethod, headers: Alamofire.HTTPHeaders?, parameters: (any JsonSerilizer)?, objectType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        return AF.request(url, method: method, parameters: parameters?.serilize(), encoding: encoding, headers: headers)
            .publishDecodable(type: T.self)
            .tryMap { response in
                guard let value = response.value else {
                    throw AFError.responseSerializationFailed(reason: .inputFileNil)
                }
                return value
            }
            .mapError { error -> Error in
                error as Error
            }
            .eraseToAnyPublisher()
    }
    }
    


class APIService2 {
    let networkService: NetworkService
    let headers : HTTPHeaders = ["Content-Type":"application/json",
                                 "Authorization":"Bearer \(AppDefaults.accessToken)"]

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func apiHandler<T: Decodable>(endpoint: String, method: HTTPMethod, parameters: JsonSerilizer?, objectType: T.Type) -> AnyPublisher<T, Error> {
            let url = URL(string: "https://swapi.dev/api/\(endpoint)")!
            return networkService.fetchData(url: url, method: method, headers: nil, parameters: parameters, objectType: objectType)
        }
}
