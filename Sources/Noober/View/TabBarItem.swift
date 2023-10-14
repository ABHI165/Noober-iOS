import SwiftUI

enum TabBarItem {
    case api
    case sharedPref
    case logs
    case more
}


extension TabBarItem {
    var color: Color {
        Color.black
    }
    
    var icon: String {
        switch self {
            case .api:
                "globe.europe.africa"
            case .sharedPref:
                "list.number"
            case .logs:
                "clock"
            case .more:
                "ellipsis.circle"
        }
    }
    
    var title: String {
        switch self {
            case .api:
                return "API"
            case .sharedPref:
                return "Properties"
            case .logs:
                return "Logs"
            case .more:
                return "More"
        }
    }
}

