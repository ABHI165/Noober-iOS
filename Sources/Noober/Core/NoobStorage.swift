import Foundation

actor NoobStorage {
    
    private init() {}
    static let shared: NoobStorage = NoobStorage()
    
    private(set) var apiModelList: [APIModel] = []
    private(set) var userProperties: [String: Any] = [:]
    private(set) var logsList: [LogModel] = []
    
    
    func saveAPICall(_ apiModel: APIModel) {
        apiModelList.append(apiModel)
    }
    
    func updateAllUserProperties(_ prop: [String: Any]) {
        userProperties = prop
    }
    
    func saveLog(_ logModel: LogModel) {
        logsList.append(logModel)
    }
}



