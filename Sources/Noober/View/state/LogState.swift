import Foundation

struct LogState: Identifiable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let isError: Bool
    let date: String
}


extension LogState {
#if DEBUG
    static let mocked = LogState(title: "Notification Received", description: "FCM", isError: false, date: "\(Date())")
#endif
    
    func matchesQuery(_ query: String) -> Bool {
        return title.localizedCaseInsensitiveContains(query) ||
        description.localizedCaseInsensitiveContains(query)
    }
}
