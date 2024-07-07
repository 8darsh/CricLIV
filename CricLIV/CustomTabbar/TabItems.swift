//
//  TabItems.swift
//  CricLIV
//
//  Created by Adarsh Singh on 18/06/24.
//

import Foundation
enum TabbedItems: Int, CaseIterable{
    
    case home = 0
    case table
    case allmatches
    case profile
    
    var title: String{
        switch self {
        case .home:
            "Home"
        case .table:
            "Points"
        case .allmatches:
            "All Matches"
        case .profile:
            "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            "house.fill"
        case .table:
            "table.fill"
        case .allmatches:
            "figure.cricket"
        case .profile:
            "person.fill"
        }
    }
}
