import Foundation

struct APIInfoState: Identifiable {
    let id = UUID().uuidString
    let summary: APISummaryState
    let requestState: HeaderBodyState
    let responseState: HeaderBodyState
}

//MARK: - Extension
extension APIInfoState {
#if DEBUG
    static let mocked = APIInfoState(summary: .mocked, requestState: .mocked, responseState: .mocked)
#endif
    
    func matchesQuery(_ query: String) -> Bool {
        return summary.matchesQuery(query) || requestState.matchesQuery(query) || responseState.matchesQuery(query)
    }
}

