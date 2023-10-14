import Foundation

/// `UserProperties` struct represents a user property key and its alternate key.
public struct UserProperties {
    /// The primary key used to access a user property.
    public let key: String
    
    /// An alternate key that can be used to access the same user property. This is helpful for cases where the same data may have different key names on Android and iOS.
    public let alternateKey: String
    
    /// Initialize a `UserProperties` instance with a primary key and an optional alternate key.
    ///
    /// - Parameters:
    ///   - key: The primary key used to access the user property.
    ///   - alternateKey: An optional alternate key that can be used to access the same user property. If not provided, it defaults to the primary key.
    public init(key: String, alternateKey: String? = nil) {
        self.key = key
        self.alternateKey = alternateKey ?? key
    }
}

