//
//  NetworkPresenter.swift
//  SwiftUIMvvmArch
//
//  Created by John on 29/11/23.
//

import Foundation
import Combine

class NetworkViewPresenter: ObservableObject {
    @Published var showNetworkView = false
    
    private var cancellables: Set<AnyCancellable> = []
    private var networkMonitor: NetworkMonitor

    init(networkMonitor: NetworkMonitor) {
        self.networkMonitor = networkMonitor

        // Observe network state changes
        networkMonitor.$isConnected
            .sink { [weak self] isConnected in
                guard let self = self else { return }
                if !isConnected {
                    self.showNetworkView = true // Show the sheet when the network is not connected
                }
                else{
                    self.showNetworkView = false
                }
            }
            .store(in: &cancellables)
    }
   
}
