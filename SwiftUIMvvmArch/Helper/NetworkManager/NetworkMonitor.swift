
//
//  Reachability.swift
//
//  Created by Vanderlei Martinelli on 19/02/20.
//  Copyright © 2020 Vanderlei Martinelli. All rights reserved.
//

import Network
import SwiftUI


 class NetworkMonitor: ObservableObject {
    
    public let networkMonitor = NWPathMonitor()
    public let workerQueue = DispatchQueue.global()
    @Published private(set) var isConnected = true
    @Published private(set) var isCellular = true

    static let shared = NetworkMonitor() // Singleton instance

       public init() {
           start()
       }
    
    public func start (){
        networkMonitor.start(queue: workerQueue)
        networkMonitor.pathUpdateHandler = {[ weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.isCellular = path.usesInterfaceType(.cellular)
            }
        }
    }
}



