import Foundation

/// `Noober` is a utility class for handling various functionalities related to Noober.
public final class Noober {
    /// Singleton instance of `Noober`.
    public static let shared = Noober()
    
    /// URLs to be ignored by Noober's functionality.
    private(set) var ignoredURLs = [String]()
    
    /// User properties to be tracked by Noober.
    private(set) var userPropertiesKey = [UserProperties]()
    
    /// The old URL that has been replaced.
    private(set) var oldURL = ""
    
    /// The new URL that replaces the old one.
    private(set) var newReplacedURL = ""
    
    /// Private initializer to ensure only one instance of `Noober`.
    private init() {}
    
    /// Start Noober's functionality.
    public func start() {
        NoobHelper.shared.startNoober()
    }
    
    /// Stop Noober's functionality.
    public func stop() {
        NoobHelper.shared.stopNoober()
    }
    
    /// Log a message with an optional error flag.
    ///
    /// - Parameters:
    ///   - tag: A tag for categorizing the log message.
    ///   - message: The log message to be recorded.
    ///   - isError: A flag to indicate if the message represents an error (default is `false`).
    public func log(tag: String, message: String, isError: Bool = false) {
        let model = LogModel(title: tag, description: message, isError: isError)
        NoobRepository.shared.saveLog(model)
    }
    
    /// Set shareable user properties for Noober.
    ///
    /// - Parameter prop: An array of user property keys to be tracked.
    public func setShareableNoobProperties(_ prop: [String]) {
        prop.forEach { key in
            userPropertiesKey.append(UserProperties(key: key))
        }
    }
    
    /// Set shareable user properties for Noober.
    ///
    /// - Parameter prop: An array of `UserProperties` objects to be tracked.
    public func setShareableNoobProperties(_ prop: [UserProperties]) {
        userPropertiesKey.append(contentsOf: prop)
    }
    
    /// Handle a Noob link with a URL.
    ///
    /// - Parameter url: The URL to be processed by Noober.
    public func handleNoobLink(_ url: URL) {
        NoobRepository.shared.importPropertiesWith(url)
    }
    
    /// Toggle Noober's functionality on or off.
    public func toggle() {
        NoobHelper.shared.toggle()
    }
    
    /// Ignore a specific URL.
    ///
    /// - Parameter url: The URL to be ignored.
    public func ignoreURL(_ url: String) {
        ignoredURLs.append(url)
    }
    
    /// Ignore multiple URLs.
    ///
    /// - Parameter urls: An array of URLs to be ignored.
    public func ignoreURLs(_ urls: [String]) {
        ignoredURLs.append(contentsOf: urls)
    }
    
    /// Replace an old URL with a new URL.
    ///
    /// - Parameters:
    ///   - oldURL: The old URL to be replaced.
    ///   - newURL: The new URL that replaces the old one.
    public func replace(url oldURL: String, with newURL: String) {
        self.oldURL = oldURL
        newReplacedURL = newURL
    }
}
