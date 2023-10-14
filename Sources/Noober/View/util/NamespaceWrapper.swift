import SwiftUI

@available(iOS 14, *)
struct NamespaceWrapper<Content: View>: View {
    @Namespace var namespace
    
    var content: Content
    
    var body: some View {
        content.environment(\.namespace, namespace)
    }
}


@available(iOS 14, *)
struct NamespaceReader<Content: View, ID: Hashable>: View {
    @Environment(\.namespace) var namespace
    
    var content: Content
    
    var id: ID
    var anchor: UnitPoint = .center
    var isSource: Bool = true
    
    var body: some View {
        content.matchedGeometryEffect(id: id, in: namespace!, anchor: anchor, isSource: isSource)
    }
}

@available(iOS 14, *)
struct NamespaceKey: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

@available(iOS 14, *)
extension EnvironmentValues {
    var namespace: Namespace.ID? {
        get {
            self[NamespaceKey.self]
        }
        set {
            self[NamespaceKey.self] = newValue
        }
    }
}
