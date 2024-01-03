//
//  SocialLoginView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 15/12/23.
//

import SwiftUI

struct SocialLoginView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    var body: some View {
   
            VStack{
                Spacer()
                Button("Sign in with Apple") {
                    authManager.appleLogin { result,stat,err  in
                        if let res = result{
                            print(res, "<<============")
                        }
                        if let state = stat{
                            print(state, "<<============")
                        }
                        if let err = err{
                            print(err.localizedDescription, "<<============")
                        }
                        // Handle result
                    }
                }
                Spacer()
                // Google Login Button
                Button("Sign in with Google") {
                    authManager.googleLogin(completion: { result,stats,err  in
                        // Handle result
                        if let state = stats{
                            print(state, "<<============")
                        }
                        if let res = result{
                            print(res, "<<============")
                        }
                        if let err = err{
                            print(err.localizedDescription, "<<============")
                        }
                    })
                }
                Spacer()
                // Facebook Login Button
                Button("Sign in with Facebook") {
                    authManager.facebookLogin { result,status,err  in
                        // Handle result
                        if let state = status{
                            print(state, "<<============")
                        }
                        if let res = result{
                            print(res, "<<============")
                        }
                        if let err = err{
                            print(err.localizedDescription, "<<============")
                        }
                    }
                }
                Spacer()
            }.navigationBarTitle("Centered Title", displayMode: .inline)
  
       
    }
}

#Preview {
    SocialLoginView()
}
