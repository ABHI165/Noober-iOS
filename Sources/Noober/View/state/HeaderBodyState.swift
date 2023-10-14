import Foundation

struct HeaderBodyState {
    let headers: [String:String]
    let body: String
}

//MARK: - Extension
#if DEBUG
extension HeaderBodyState {
    static let mocked = HeaderBodyState(headers: ["token": "ffdfdf", "Content-Type": "application/json"], body: "{something: 123, anotherKey: ff}")
}
#endif


extension HeaderBodyState {
    func matchesQuery(_ query: String) -> Bool {
        return headers.contains(where: {$0.key.localizedCaseInsensitiveContains(query) || $0.value.localizedCaseInsensitiveContains(query)}) ||
        body.localizedCaseInsensitiveContains(query)
    }
}
