import SwiftUI

struct NoobTabPrefrenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct NoobTabView<Content: View>: View {
    
    @Binding private var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    private let content: Content
    
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            NoobTabFooterView(tabs: tabs, selected: $selection)
        }
        .onPreferenceChange(NoobTabPrefrenceKey.self) { value in
            self.tabs = value
        }
    }
}
