//
//  BaseVC.swift
//  ApiDemoWithFuture
//
//  Created by John on 27/04/23.
//

import UIKit
import Combine

class BaseVC: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        Networklost()
        // Do any additional setup after loading the view.
    }
    
    func Networklost(){
        Reachability.shared.publisher
                   .sink { path in
                       if path.isReachable {
                           
                           print("isOn")
//                           self.ImageView?.isHidden = true
                          
                       } else {
                           print("isOff")
//                           self.ImageView?.isHidden = false
                         
                       }
                   }
                   .store(in: &subscriptions)
    }
    func showError(_ error: Error) {
        // Show an error message to the user
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoader(){
        
    }
    func hideLoader(){
        
    }

}
