//
//  ContentView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 06/10/23.
//
import UIKit
import SwiftUI



struct ContentView: View {
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var isLoaderShowing = false
    @State private var showErrorAlert = false
   
    var body: some View {

        ZStack {
            VStack{
                    let person = viewModel.appResponse.country
                      Button(action: {
                          viewModel.getPerson()
                      }) {
                          Text("Hit API")
                              .font(.system(size: 20))
                      }
                      .padding()
                      Spacer()
                //MARK: single dictionary data
//                    Text("Name: \(person.name ?? (AppDefaults.userData?.name ?? "ishpreet"))")
//                      Spacer()
//                    Text("Height: \(person.height ?? (AppDefaults.userData?.height ?? "184"))")
//                      Spacer()
                //MARK: array dictionary data
                List(viewModel.appResponse.country, id: \.cca2) { country in
                    Text(country.name?.common ?? "")
                          }
                
            }.opacity(viewModel.isLoading ? 0.5 : 1.0)
            if viewModel.isLoading {
                
                LoaderView(isShowing: $isLoaderShowing)
                    .onAppear {
                        isLoaderShowing = true
                    }
            }
        }.onAppear{
            viewModel.getPerson()
        }
        .padding()
        .errorAlert(isPresented: $showErrorAlert, title: "", message: "\(viewModel.error?.localizedDescription ?? "Screeen Eror")")
        .onReceive(viewModel.$error) { error in
            if error != nil {
                showErrorAlert = true
            }
        }
    }
   
}

#Preview {
    ContentView()
}


