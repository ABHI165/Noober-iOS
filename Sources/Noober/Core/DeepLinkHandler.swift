import Foundation

enum Constants {
    static let NOOB_SCHEME = "noober"
    static let NOOB_HOST = "open"
    static let IS_FROM_ANDROID = "is_from_android"
}

class DeepLinkHandler {
    
    static func generateDeepLink(userProp: [String: Any]) -> String {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.NOOB_SCHEME
        urlComponent.host = Constants.NOOB_HOST
        
        var queryItems = [URLQueryItem]()
        for (key, value) in userProp {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        queryItems.append(URLQueryItem(name: Constants.IS_FROM_ANDROID, value: "0"))
        urlComponent.queryItems = queryItems
        
        return urlComponent.url?.absoluteString ?? ""
    }
    
    static func handleDeepLink(url: URL) {
        guard url.host == Constants.NOOB_HOST, url.scheme == Constants.NOOB_SCHEME else { return }
        
        var parameters = [String: String]()
        if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
            for queryItem in queryItems {
                parameters[queryItem.name] = queryItem.value ?? ""
            }
        }
        
        UserDefaultsManager.updateAndSaveValuesInUserDefaults(parameters)
    }
}
