//
//  CustomTabBarView.swift
//  CustomNavigationView
//
//  Created by John on 01/01/24.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs : [TabBaritem]
    @Binding var selection : TabBaritem
    @Namespace private var namespace
    
    var body: some View {
        
                tabBarVerion1
//        tabBarVerion2
        
    }
}
struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [TabBaritem] = [
            .Contact,.Favorite,.Settings,.home
        ]
        VStack{
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
        }
        
    }
}


extension CustomTabBarView {
    func tabview1(tab : TabBaritem) -> some View {
        VStack{
            
            Group {
                if selection == tab {
                    tab.Selectedimage
                } else {
                    tab.unselectimage
                }
            }
            .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.selectedColor : tab.unselectedColor)
        .padding(.vertical,8)
        .frame(maxWidth: .infinity)
        //   MARK:   use it according to need
        //            .background(selection == tab ? tab.color.opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
     
                
           
    }
    func switchToTab (tab:TabBaritem){
        withAnimation(.easeOut) {
            selection = tab
        }
    }
    
    
    private var tabBarVerion1: some View{
        HStack{
            
            ForEach(tabs , id: \.self) { tab in
                tabview1(tab: tab)
                    
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
         .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
           


    }
}

extension CustomTabBarView {
    func tabview2(tab : TabBaritem) -> some View {
        VStack{
            
            Group {
                if selection == tab {
                    tab.Selectedimage
                } else {
                    tab.unselectimage
                }
            }
            .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
        }
        .foregroundColor(selection == tab ? tab.selectedColor : tab.unselectedColor)
        .padding(.vertical,8)
        .frame(maxWidth: .infinity)
        
        //   MARK:   use it according to need
        //           .background(
        //            ZStack{
        //                if selection == tab {
        //                    RoundedRectangle(cornerRadius: 10)
        //                        .fill(tab.selectedBoxColor.opacity(0.2))
        //                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
        //                }
        //            }
        //           )
        //           .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var tabBarVerion2: some View{
        HStack{
            ForEach(tabs , id: \.self) { tab in
                tabview2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10,x: 0,y: 5)
        .padding(.horizontal)
    }
}
