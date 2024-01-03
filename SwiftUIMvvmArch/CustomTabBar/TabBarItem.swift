//
//  TabBarItem.swift
//  CustomNavigationView
//
//  Created by John on 02/01/24.
//

import Foundation
import SwiftUI


enum TabBaritem : Hashable{
    case home, Favorite,Settings,Contact
     
    var Selectedimage : Image{
        switch self{
        case .home:
            return Image("home_select")
        case .Favorite:
            return Image("heart_select")
        case .Settings:
            return Image("setting_select")
        case .Contact:
            return Image("contact_select")
        }
    }
    var title : String{
        switch self{
        case .home:
            return "Home"
        case .Favorite:
            return "Favorite"
        case .Settings:
            return "Settings"
        case .Contact:
            return "Contact"
        }
    }
    var selectedBoxColor: Color{
        switch self{
        case .home:
            return Color.blue
        case .Favorite:
            return Color.green
        case .Settings:
            return Color.yellow
        case .Contact:
            return Color.red
        }
    }
    var selectedColor: Color{
        switch self{
        case .home:
            return Color.blue
        case .Favorite:
            return Color.blue
        case .Settings:
            return Color.blue
        case .Contact:
            return Color.blue
        }
    } 
    var unselectedColor: Color{
        switch self{
        case .home:
            return Color.gray
        case .Favorite:
            return Color.gray
        case .Settings:
            return Color.gray
        case .Contact:
            return Color.gray
        }
    }
    var unselectimage: Image{
        switch self{
        case .home:
            return Image("home_Unselect")
        case .Favorite:
            return Image("heart_unselect")
        case .Settings:
            return Image("setting_unselect")
        case .Contact:
            return Image("Contact_unselect")
        }
    }
}


