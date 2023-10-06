//
//  AppDefault.swift
//  ApiDemoWithFuture
//
//  Created by John on 27/04/23.
//

import Foundation
struct  AppDefaults{
    
    static var accessToken: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
        get{
            return UserDefaults.standard.string(forKey:  "accessToken") ?? ""
        }
    }
    static var userData: Person? {
            set {
                guard let newValue = newValue else {
                    UserDefaults.standard.set(nil, forKey: "userData")
                    return
                }
                
                do {
                    let data = try PropertyListEncoder().encode(newValue)
                    UserDefaults.standard.set(data, forKey: "userData")
                } catch {
                    print("Error encoding user data: \(error.localizedDescription)")
                }
            }
            
            get {
                guard let data = UserDefaults.standard.data(forKey: "userData") else {
                    return nil
                }
                
                do {
                    let userData = try PropertyListDecoder().decode(Person.self, from: data)
                    return userData
                } catch {
                    print("Error decoding user data: \(error.localizedDescription)")
                    return nil
                }
            }
        }

}
