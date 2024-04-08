//
//  DIViewmodel.swift
//  SwiftUIMvvmArch
//
//  Created by John on 08/04/24.
//

import Foundation
import Combine

class DIViewModel: ObservableObject {
    @Published var error: Error?
    let commonRequest = CommonRequest()
    private let apiService2: APIService2
    var cancellables = Set<AnyCancellable>()
    @Published var appResponse: AppResponse = AppResponse()
    @Published var person :Person = Person()
    @Published var isLoading = false
    
    init(apiService2: APIService2) {
            self.apiService2 = apiService2
        }
    func fetchDataFromAPI() {
        isLoading = true
           apiService2.apiHandler(endpoint: "people/1", method: .get, parameters: commonRequest, objectType: Person.self)
               .sink(receiveCompletion: { completion in
                   self.isLoading = false
                   switch completion {
                   case .finished:
                       // API request completed
                       break
                   case .failure(let error):
                       // Handle API request failure
                       self.error = error
                   }
               }, receiveValue: { responseData in
                   print("d;fkbgjveorbgvekorubgi\(responseData)")
                   self.person = responseData
                   self.appResponse.person = responseData

//                 print("\(responseData)")
               })
               .store(in: &cancellables)
       }
}
