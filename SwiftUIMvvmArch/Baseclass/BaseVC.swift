//
//  BaseVC.swift
//  ApiDemoWithFuture
//
//  Created by John on 27/04/23.
//

import UIKit
import Combine
import SwiftUI
import Lottie

//class BaseVC : UIViewController {
//    var subscriptions = Set<AnyCancellable>()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        Networklost()
//        // Do any additional setup after loading the view.
//    }
//    
//    func Networklost(){
//        Reachability.shared.publisher
//                   .sink { path in
//                       if path.isReachable {
//                           
//                           print("isOn")
////                           self.ImageView?.isHidden = true
//                          
//                       } else {
//                           print("isOff")
////                           self.ImageView?.isHidden = false
//                         
//                       }
//                   }
//                   .store(in: &subscriptions)
//    }
//    func showError(_ error: Error) {
//        // Show an error message to the user
//        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//    
////    func ShowLoader(){
////       
////        newLoader.isHidden = false
////        self.view.isUserInteractionEnabled = false
////        newLoader.play()
////    }
////    func HideLoader(){
////        newLoader.isHidden = true
////        
////        self.view.isUserInteractionEnabled = true
////        
////    }
//
//}

class BaseViewModel: ObservableObject {
//    var subscriptions = Set<AnyCancellable>()
//
//    init() {
//        Networklost()
//    }
//
//    func Networklost() {
//        Reachability.shared.publisher
//            .sink { path in
//                if path.isReachable {
//                    print("isOn")
//                } else {
//                    print("isOff")
//                }
//            }
//            .store(in: &subscriptions)
//    }
  


}




struct ErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    var title: String
    var message: String

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}
extension View {
    func errorAlert(isPresented: Binding<Bool>, title: String, message: String) -> some View {
        self.modifier(ErrorAlertModifier(isPresented: isPresented, title: title, message: message))
    }
}



