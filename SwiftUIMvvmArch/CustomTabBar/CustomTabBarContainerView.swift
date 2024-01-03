//
//  CustomTabBarContainerView.swift
//  CustomNavigationView
//
//  Created by John on 02/01/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    @Binding var selection :TabBaritem
    let content : Content
    @State  var tabs: [TabBaritem] = []
    init(selection: Binding<TabBaritem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        
        //MARK: USE THE TABVIEWVERSION 2 USE THIS CODE :-----
        ZStack(alignment: .bottom, content: {
            content
                .ignoresSafeArea()
          
            CustomTabBarView(tabs: tabs, selection: $selection)
        })
     
        
        //MARK: IF USE THE TABVIEWVERSION 1 USE THIS CODE :------
//        VStack(spacing: 0, content: {
//            ZStack(content: {
//                content
//            })
//            CustomTabBarView(tabs: tabs, selection: $selection)
//        })
        .onPreferenceChange(TabBarItemPrefrenceKey.self) { value in
            self.tabs = value
        }
    }
}


struct CustomTabBarContainerView_Previews: PreviewProvider {
  
    
    static var previews: some View {
        let tabs: [TabBaritem] = [
            .home, .Contact,.Favorite,.Settings
        ]
        CustomTabBarContainerView(selection: .constant(tabs.first!), content: {
            Color.red
        })
      
    }
}

