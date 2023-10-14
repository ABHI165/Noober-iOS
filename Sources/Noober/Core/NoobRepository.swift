import Foundation
import Combine

final class NoobRepository {
    private let noobStorage = NoobStorage.shared
    static let shared = NoobRepository()
    
    let apiModelListPublisher = PassthroughSubject<[APIModel], Never>()
    let userPropertiesPublisher = PassthroughSubject<[String: Any], Never>()
    let logsPublisher = PassthroughSubject<[LogModel], Never>()
    
    
    private init() {}
    
    func addAPIModel(_ model: APIModel) {
        Task {
            await noobStorage.saveAPICall(model)
            let updatedAPIModelList = await noobStorage.apiModelList
            apiModelListPublisher.send(updatedAPIModelList.reversed())
        }
    }
    
    func getAllUserProperties() {
        Task {
            if let prop = await UserDefaultsManager.fetchDataFromUserDefaults() {
                await noobStorage.updateAllUserProperties(prop)
                let updatedProp = await noobStorage.userProperties
                userPropertiesPublisher.send(updatedProp)
            }
        }
    }
    
    func updateValueInUserDefaults(forKey key: String, newValue: String) {
        UserDefaultsManager.updateValueInUserDefaults(forKey: key, newValue: newValue)
        getAllUserProperties()
    }
    
    func saveLog(_ model: LogModel) {
        Task {
            await noobStorage.saveLog(model)
            let updatedLogs = await noobStorage.logsList
            logsPublisher.send(updatedLogs.reversed())
        }
    }
    
    func generateDeepLink() -> String {
        let data = UserDefaultsManager.fetchValuesForKeys(Noober.shared.userPropertiesKey.map{$0.key})
        return DeepLinkHandler.generateDeepLink(userProp: data)
    }
    
    func restoreProperties() {
        UserDefaultsManager.restoreOldValues()
        getAllUserProperties()
    }
    
    func importPropertiesWith(_ url: URL) {
        DeepLinkHandler.handleDeepLink(url: url)
        Haptic.successFeedback()
        getAllUserProperties()
    }
}
