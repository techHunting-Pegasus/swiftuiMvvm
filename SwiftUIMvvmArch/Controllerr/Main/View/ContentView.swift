//
//  ContentView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    
  
    var body: some View {
        VStack {
            

            if viewModel.isLoading {
                // Show ProgressView when isLoading is true
                ProgressView("Loading...")
            } else {
                let person = viewModel.appResponse.person // Non-optional Person
                Text("Name: \(person.name ?? "ishpreet")")
                Text("Height: \(person.height ?? "184")")
            }

            if let error = viewModel.error {
                // Show error message when error is not nil
                Text("Error: \(error.localizedDescription)")
            } else if !viewModel.isLoading {
                // Show the "Hit API" button when isLoading is false
                Button {
                    viewModel.getPerson()
                } label: {
                    Text("Hit API").font(.system(size: 20))
                }
            } else {
                // Show "Data not available" when none of the above conditions are met
                Text("Data not available")
            }

        }
        .padding()
        .onReceive(viewModel.$type) { newType in
            switch newType {
            case .getuser:
                print("res")
            case .appointment:
                print("")
            case .postApi:
                print("hello api hit successfully")
            case .none:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
