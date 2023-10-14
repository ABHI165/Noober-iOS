import Foundation

struct UserDefaultsManager {
    
    private static let userDefaults = UserDefaults.standard
    private static let noobDefaults = UserDefaults(suiteName: "Noob")
    
    static func fetchDataFromUserDefaults(useNoobSuite: Bool = false) async -> [String: Any]? {
        return await withCheckedContinuation { continuation in
            let data = useNoobSuite ? noobDefaults?.dictionaryRepresentation() : userDefaults.dictionaryRepresentation()
            continuation.resume(returning: data)
        }
    }
    
    static func fetchValuesForKeys(_ keys: [String]) -> [String: Any] {
        return userDefaults.dictionaryWithValues(forKeys: keys)
    }
    
    // Function to update a value in UserDefaults
    static func updateValueInUserDefaults(forKey key: String, newValue: String) {
        let userDefaults = UserDefaults.standard
        if let oldValue = userDefaults.value(forKey: key) {
            if oldValue is Int, let newValueAsInt = Int(newValue) {
                userDefaults.set(newValueAsInt, forKey: key)
                
            } else if oldValue is Float, let newValueAsFloat = Float(newValue) {
                userDefaults.set(newValueAsFloat, forKey: key)
                
            } else if oldValue is Bool, let newValueAsBool = Bool(newValue) {
                userDefaults.set(newValueAsBool, forKey: key)
                
            }
            else if oldValue is Double, let newValueAsBool = Double(newValue) {
                userDefaults.set(newValueAsBool, forKey: key)
                
            } else if oldValue is String {
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
    
    static func updateAndSaveValuesInUserDefaults(_ propeties: [String: String]) {
        UserDefaults.standard.removeSuite(named: "Noob")
        propeties.forEach { (key: String, value: String) in
            updateAndSaveValueInUserDefaults(forKey: key, newValue: value)
        }
    }
    
    static func restoreOldValues() {
        if let noobDefaults = noobDefaults {
            Task {
                if let oldValues = await fetchDataFromUserDefaults(useNoobSuite: true) {
                    oldValues.forEach { (key: String, value: Any) in
                        updateValueInUserDefaults(forKey: key, newValue: String(describing: value))
                    }
                    UserDefaults.standard.removeSuite(named: "Noob")
                }
            }
        }
    }
    
    private static func updateAndSaveValueInUserDefaults(forKey key: String, newValue: String) {
        if let oldValue = userDefaults.value(forKey: key), let noobDefaults = noobDefaults {
            noobDefaults.set(oldValue, forKey: key)
            updateValueInUserDefaults(forKey: key, newValue: newValue)
        }
    }
    
}
