//
//  ContentView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 06/10/23.
//
import UIKit
import SwiftUI
import Combine
import GoogleSignIn


struct ContentView: View {
    
    
    @EnvironmentObject var networkViewPresenter: NetworkViewPresenter
    
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var isLoaderShowing = false
    @State private var showErrorAlert = false
    
    @State private var isSocialLofinScreen = false
    
    
    var body: some View {

          
            ZStack {
                
                VStack{
                  
                    Button {
                        isSocialLofinScreen = true
                    } label: {
                        Text("navigate to social login")
                            .font(.system(size: 16))
                    }
                    let _ = viewModel.appResponse.country
                    Button(action: {
                        viewModel.getPerson()
                    }) {
                        Text("Hit API")
                            .font(.system(size: 16))
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
                    
                    
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
                
                
                if viewModel.isLoading {
                    
                    LoaderView(isShowing: $isLoaderShowing)
                        .onAppear {
                            isLoaderShowing = true
                        }
                }
                
                
            }
//            .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                 
//                            Text("Nav Title")
//                              .font(.system(size: 30))
//                              .foregroundColor(Color.black)
//                    Spacer()
//                    }
//                }
          
          
     
        .navigate(to: SocialLoginView(), when: $isSocialLofinScreen)
        .sheet(isPresented: $networkViewPresenter.showNetworkView) {
            NetworkView()
                .interactiveDismissDisabled(true)
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


extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarHidden(false)
                
                NavigationLink(
                    destination: view,
                    
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
      
      
        .navigationViewStyle(.stack)
        
        
    }
}



