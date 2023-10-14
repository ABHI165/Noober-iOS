import SwiftUI

extension View {
    func noobTabItem(_ item: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        self
            .opacity(selection.wrappedValue == item ? 1 : 0)
            .preference(key: NoobTabPrefrenceKey.self, value: [item])
    }
    
    func namespaced() -> AnyView {
        if #available(iOS 14, *) {
            return AnyView(NamespaceWrapper(content: self))
        } else {
            return AnyView(self)
        }
    }
    
    func namespacedMatchedGeometryEffect<ID>(id: ID, anchor: UnitPoint = .center, isSource: Bool = true) -> some View where ID : Hashable {
        if #available(iOS 14, *) {
            return AnyView(NamespaceReader(content: self, id: id, anchor: anchor, isSource: isSource))
        } else {
            return AnyView(self)
        }
    }
    
    func onTap(_ action: @escaping ()-> Void) -> some View {
        contentShape(Rectangle())
            .onTapGesture(perform: action)
    }
    
#if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
#endif
}
