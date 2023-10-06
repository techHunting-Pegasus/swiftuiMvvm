//
//  ApiService.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation
import Alamofire
import Combine


class APIService{
  //static let shared = APIService()
//    var headers:HTTPHeaders = [:]
    
    let headers : HTTPHeaders = ["Content-Type":"application/json",
                                 "Authorization":"Bearer \(AppDefaults.accessToken)"]
 
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForResource = 30 // seconds
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return Session(configuration: configuration)
    }()
    
   
    

    func apiHandler<T: Decodable>(endpoint: String, parameters: JsonSerilizer, method: HTTPMethod, objectType: T.Type) -> AnyPublisher<T, Error> {
        print("*************** HEADERS *****************")
        
        let url = URL(string: "\(Constant.BASEURL)\(endpoint)")!
        print(url, headers)
        
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        
        return Future { promise in
            AF.request(url, method: method, parameters: parameters.serilize(), encoding: encoding)
                .validate()
                .responseDecodable(of: objectType) { response in
                    switch response.result {
                    case .success(let object):
                        promise(.success(object))
                        print(object)
                    case .failure(let error):
                        promise(.failure(error))
                        print(error)
                    }
                }
        }
        .eraseToAnyPublisher()
    }
    

    
//MARK: MULTIPLEA API GENRIC FUNCTION
    func MultipleAPI<T: Decodable>(endpoints: [String], objectType: T.Type) -> AnyPublisher<[T], Error> {
        let requests = endpoints.map { endpoint -> AnyPublisher<T, Error> in

            let url = URL(string: "\(Constant.BASEURL)\(endpoint)")!
            return sessionManager.request(url, method: .get, parameters: [:], headers: headers)
                .validate()
                .publishDecodable(type: objectType)
                .value()
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(requests)
            .collect()
            .eraseToAnyPublisher()
    }
   

    
 
    
    func GetWithSetUrl<T: Decodable>(baseURL: String, headers: HTTPHeaders, path: String, objectType: T.Type) -> AnyPublisher<T, Error> {
        let fullURL = "\(baseURL)\(headers)"
       // modify headers as needed

        return GetWithSetUrl(url: fullURL, headers: self.headers, objectType: objectType)
    }

    func GetWithSetUrl<T: Decodable>(url: String, headers: HTTPHeaders, objectType: T.Type) -> AnyPublisher<T, Error> {
        print("*************** HEADERS *****************")
        print(url,headers)
        return Future { (promise: @escaping (Result<T, Error>) -> Void) in
            AF.request(url,method: .get,parameters: [:],headers: headers)
                .validate() // Add a "validate" call to ensure a successful response
                .responseDecodable(of: objectType) { response in
                switch response.result {
                case .success(let object):
                    promise(.success(object))

                    print(object)
                case .failure(let error):
                    promise(.failure(error))
                    print(error)
                }
            }
        }
        .eraseToAnyPublisher()
    }
   
    
    
    
   }
    
    func postMultipart<T: Decodable>(url: String, parameters: Parameters?, objectType: T.Type, imageData: Data, imageName: String) -> AnyPublisher<T, Error> {
        return Future { promise in
            
            AF.upload(multipartFormData: { multipartFormData in
                if let parameters = parameters {
                    for (key, value) in parameters {
                        if let stringValue = value as? String {
                            multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                        }
                        if let dataValue = value as? Data {
                            multipartFormData.append(dataValue, withName: key, fileName: imageName, mimeType: "image/jpeg")
                        }
                    }
                }
                multipartFormData.append(imageData, withName: "image", fileName: imageName, mimeType: "image/jpeg")
            }, to: url, method: .post)
            .debugLog()
            .responseDecodable(of: objectType) { response in
                switch response.result {
                case .success(let object):
                    promise(.success(object))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    
    



extension DataRequest {
    @discardableResult
    func debugLog() -> Self {
#if DEBUG
        debugPrint(self)
#endif
        return self
    }
}

extension AFError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url) - \(self.localizedDescription)"
        case .parameterEncodingFailed(let reason):
            return "Parameter encoding failed: \(reason) - \(self.localizedDescription)"
        case .multipartEncodingFailed(let reason):
            return "Multipart encoding failed: \(reason) - \(self.localizedDescription)"
        case .responseSerializationFailed(let reason):
            return "Response serialization failed: \(reason) - \(self.localizedDescription)"
        case .responseValidationFailed(let reason):
            return "Response validation failed: \(reason) - \(self.localizedDescription)"
        case .sessionTaskFailed(let error):
            return "Session task failed: \(error.localizedDescription) - \(self.localizedDescription)"
        case .urlRequestValidationFailed(let reason):
            return "URL request validation failed: \(reason) - \(self.localizedDescription)"
        default:
            return self.localizedDescription
        }
    }
}

enum APIError: Error {
    case emptyResponse
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .emptyResponse:
            return "The API response is empty."
        case .decodingError:
            return "Failed to decode the API response."
        }
    }
}
