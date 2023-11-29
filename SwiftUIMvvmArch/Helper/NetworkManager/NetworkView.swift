//
//  NetworkView.swift
//  SwiftUIMvvmArch
//
//  Created by John on 29/11/23.
//

import SwiftUI

struct NetworkView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("No Internet Connection")
                .font(.headline)
                .foregroundColor(.red)
                .padding()
                .foregroundColor(.white)
                
                .cornerRadius(8)
        }
        .padding()
        .background(
            Color.white)
        
    }
}

#Preview {
    NetworkView()
}
