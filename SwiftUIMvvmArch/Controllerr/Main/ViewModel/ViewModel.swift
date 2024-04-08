//
//  ViewModel.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation
import Combine
import Alamofire


class ViewModel: ObservableObject {
    private var apiService = APIService()
   
    
    @Published var appResponse: AppResponse = AppResponse()
    @Published var error: Error?
    @Published var isLoading = false

    
    let commonRequest = CommonRequest()
    
    var cancellables = Set<AnyCancellable>()
    
   
    let dispatchGroup = DispatchGroup()
    
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
   

    
    let apiRequests: [MultipleAPIRequest<Decodable>] = [
      MultipleAPIRequest(url: URL(string: "https://api.example.com/data1")!, model: Person.self),
      MultipleAPIRequest(url: URL(string: "https://api.example.com/data2")!, model: Person2.self),
      MultipleAPIRequest(url: URL(string: "https://api.example.com/data10")!, model: Appointment.self),
    ]
    

    
    func getPerson() {
        isLoading = true
        apiService.apiHandler(endpoint: Constant.endpoint.person1, parameters: commonRequest, method: .get, objectType: Person.self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
            }, receiveValue: { [weak self] res in
                
                self?.appResponse.person = res
//                AppDefaults.userData = res
            })
            .store(in: &cancellables)
    }
    
    func create(createuserdata: AppRequest) {
        isLoading = true
        apiService.apiHandler(endpoint: Constant.endpoint.create, parameters: createuserdata , method: .post, objectType: createuser.self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
            }, receiveValue: { [weak self] res in
                
                self?.appResponse.createuUser = res
            })
            .store(in: &cancellables)
    }

//    
//    func getMultipledata() {
//      
//        let dispatchGroup = DispatchGroup()
//   
//        
//        for request in apiRequests {
//            dispatchGroup.enter()
//            
//            apiService.multipleApiCalling(from: request.url, model: request.model)
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure(let error):
//                        print("Failed to fetch and decode model: \(error)")
//                    }
//                    dispatchGroup.leave()
//                }, receiveValue: { modelData in
//                    if let data = modelData as? Person {
//                        var globalModel1Data = data
//                        print("data===> \(data)");
//                    } else if let data = modelData as? Person2 {
//                        var globalModel2Data = data
//                        print("data===> \(data)");
//                    } else if let data = modelData as? Appointment {
//                        var globalModel10Data = data
//                        print("data===> \(data)");
//                    }
//                    // Handle your success case, perhaps store the data in an array or use it directly
//                    print("Successfully fetched and decoded model: \(modelData)")
//                })
//                .store(in: &cancellables)
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            print("All API requests and model decodings are completed.")
//        }
//    }
    func getMultipledata() {
        let dispatchGroup = DispatchGroup()
        let publishers = apiRequests.map { request -> AnyPublisher<Any, Error> in
            let publisher = apiService.multipleApiCalling(from: request.url, model: request.model)
                .handleEvents(receiveOutput: { (_: _) in // Specify the type of the parameter
                    dispatchGroup.leave()
                })
                .eraseToAnyPublisher()
            dispatchGroup.enter()
            return publisher
        }
        Publishers.MergeMany(publishers)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("All API requests and model decodings are completed.")
                case .failure(let error):
                    print("Failed to fetch and decode model: \(error)")
                }
            }, receiveValue: { modelData in
                switch modelData {
                case let data as Person:
                    var globalModel1Data = data
                    print("data===> \(data)")
                case let data as Person2:
                    var globalModel2Data = data
                    print("data===> \(data)")
                case let data as Appointment:
                    var globalModel10Data = data
                    print("data===> \(data)")
                default:
                    print("Unknown model type")
                }
                // Handle your success case, perhaps store the data in an array or use it directly
                print("Successfully fetched and decoded model: \(modelData)")
            })
            .store(in: &cancellables)
    }

    

}


struct MultipleAPIRequest<ModelType: Decodable> {
    let url: URL
    let model: ModelType.Type
}


