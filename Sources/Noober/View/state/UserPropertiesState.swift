import Foundation

struct UserPropertiesState {
    let key: String
    let value: String
    let valueType: String
}


extension UserPropertiesState {
#if DEBUG
    static let mocked = UserPropertiesState(key: "token", value: "sdfgn", valueType: "String")
#endif
    
    static func convertToState(_ prop: [String: Any]) -> [UserPropertiesState] {
        var state = [UserPropertiesState]()
        
        prop.forEach { (key: String, value: Any) in
            state.append(UserPropertiesState(key: key, value: String(describing: value), valueType: String(describing: type(of: value))))
        }
        return state
    }
    
    func matchesQuery(_ query: String) -> Bool {
        return key.localizedCaseInsensitiveContains(query) ||
        value.localizedCaseInsensitiveContains(query)
    }
}
