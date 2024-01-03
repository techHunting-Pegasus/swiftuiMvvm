//
//  TabBarItemPrefrenceKey.swift
//  CustomNavigationView
//
//  Created by John on 02/01/24.
//

import Foundation
import SwiftUI

struct TabBarItemPrefrenceKey : PreferenceKey{
    static var defaultValue:  [TabBaritem] = []
    static func reduce(value: inout [TabBaritem], nextValue: () -> [TabBaritem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier :ViewModifier{
    let tab : TabBaritem
    @Binding var selection : TabBaritem
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemPrefrenceKey.self, value: [tab])
    }
}
extension  View{
    func tabBarItem(tab:TabBaritem,selection : Binding<TabBaritem>) -> some View{
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
