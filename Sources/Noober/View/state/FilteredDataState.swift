import Foundation

struct FilteredDataState: Identifiable {
    let id = UUID().uuidString
    let apiCalls: [APIInfoState]
    let userProperties: [UserPropertiesState]
    let logs: [LogState]
    
    init(apiCalls: [APIInfoState] = [], userProperties: [UserPropertiesState] = [], logs: [LogState] = []) {
        self.apiCalls = apiCalls
        self.userProperties = userProperties
        self.logs = logs
    }
}

#if DEBUG
extension FilteredDataState  {
    static let mocked = FilteredDataState(apiCalls: [.mocked, .mocked, .mocked], userProperties: [.mocked, .mocked], logs: [.mocked])
}
#endif
