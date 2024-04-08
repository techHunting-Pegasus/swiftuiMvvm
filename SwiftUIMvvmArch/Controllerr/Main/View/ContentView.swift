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
   
    
    let apiService2: APIService2
    @ObservedObject var viewModel2: DIViewModel
       
       init() {
           self.apiService2 = APIService2(networkService: NetworkManager())
           self.viewModel2 = DIViewModel(apiService2: self.apiService2)
       }
    
    var body: some View {

          
            ZStack {
                
                if #available(iOS 17.0, *) {
                    VStack{
                        
                        Button {
                            isSocialLofinScreen = true
                        } label: {
                            Text("navigate to social login")
                                .font(.system(size: 16))
                        }
                        //                    let pers = viewModel2.appResponse.person
                        let pers = viewModel2.person
                        Button(action: {
                            viewModel2.fetchDataFromAPI()
                            //                        viewModel.getPerson() 
                        }) {
                            Text("Hit API")
                                .font(.system(size: 16))
                        }
                        .padding()
                        Spacer()
                        //MARK: single dictionary data
                        Text("Name: \(viewModel2.person.name ?? (AppDefaults.userData?.name ?? "ishpreet"))")
                        Spacer()
                        Text("Height: \(pers.height ?? (AppDefaults.userData?.height ?? "184"))")
                        //                                          Spacer()
                        //MARK: array dictionary data
                        //                    List(viewModel.appResponse.country, id: \.cca2) { country in
                        //                        Text(country.name?.common ?? "")
                        //                    }
                        
                        
                    }
                    .onChange(of: viewModel2.person, { oldValue, newValue in
                        print(newValue)
                    })
                    .opacity(viewModel2.isLoading ? 0.5 : 1.0)
                } else {
                    // Fallback on earlier versions
                }
                
                
                if viewModel2.isLoading {
                    
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



