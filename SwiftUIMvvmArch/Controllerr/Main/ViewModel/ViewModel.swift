//
//  ViewModel.swift
//  ApiDemoWithFuture
//
//  Created by John on 26/04/23.
//

import Foundation
import Combine

enum AppType {
    case appointment
    case getuser
    case postApi
    case none
}

class ViewModel: ObservableObject {
    private var apiService = APIService()
    
    @Published var appResponse: AppResponse = AppResponse()
    @Published var error: Error?
    @Published var isLoading = false
    @Published var type: AppType = .none
    
    let commonRequest = CommonRequest()
    
    var cancellables = Set<AnyCancellable>()
    
    let endpoints = [
        "people/1",
        "people/2",
        "people/3",
        "people/4",
        "people/5",
        "people/6",
        "people/7",
        "people/8",
        "people/9",
        "people/10"
    ]
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
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
                self?.type = .getuser
                self?.appResponse.person = res
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
                self?.type = .postApi
                self?.appResponse.createuUser = res
            })
            .store(in: &cancellables)
    }

    
//    func multipleAPI(){
////        let objectTypeArray = [Person.self, Person2.self, Appointment.self] as [Any]
//
//        isLoading = true
//        apiService.MultipleAPI(endpoints: endpoints, objectType: Person2.self)
//            .sink(receiveCompletion: { completion in
//                self.isLoading = false
//                switch completion {
//                case .finished:
//                    print("All requests completed.")
//                case .failure(let error):
//                    print("Error:", error)
//                }
//            }, receiveValue: { people in
//                print("Received people:", people)
//
//            })
//            .store(in: &cancellables)
//    }
    
    
//    func multipleAPiDATA(){
////        let endpoints = ["endpoint1", "endpoint2", "endpoint3"]
//        let objectTypeArray = [Person.self, Person2.self, Appointment.self] as [Any]
//
//        apiService.MultipleAPI(endpoints: endpoints, objectType: objectTypeArray)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("All requests completed.")
//                case .failure(let error):
//                    print("Error:", error)
//                }
//            }, receiveValue: { results in
//                for (index, result) in results.enumerated() {
//                    switch result {
//                    case let model1 as Person:
//                        // handle response for Model1
//                        print("Received Model1 #\(index + 1):", model1)
//                    case let model2 as Person2:
//                        // handle response for Model2
//                        print("Received Model2 #\(index + 1):", model2)
//                    case let model3 as Appointment:
//                        // handle response for Model3
//                        print("Received Model3 #\(index + 1):", model3)
//                    default:
//                        // handle unexpected response
//                        print("Received unexpected response:", result)
//                    }
//                }
//            }).store(in: &cancellables)
//    }
    

}
