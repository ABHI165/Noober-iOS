import SwiftUI

struct NoobTabFooterView: View {
    private let tabs: [TabBarItem]
    @Binding private var selected: TabBarItem
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    
    init(tabs: [TabBarItem], selected: Binding<TabBarItem>) {
        self.tabs = tabs
        self._selected = selected
        impactFeedback.prepare()
    }
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { item in
                TabItemView(item)
                    .contentShape(Rectangle())
                    .onTap {
                        withAnimation(.bouncy) {
                            selected = item
                            impactFeedback.impactOccurred()
                        }
                    }
            }
        }
        .padding(6)
        .background(Blur(style: .systemUltraThinMaterialLight))
        .cornerRadius(10)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
        .padding(.horizontal)
        .namespaced()
    }
    
    
    @ViewBuilder
    private func TabItemView(_ item: TabBarItem) -> some View {
        VStack {
            Image(systemName: item.icon)
                .font(.subheadline)
            Text(item.title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selected == item ? .white : .black)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if selected == item {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .namespacedMatchedGeometryEffect(id: "NoobTabView")
                }
            }
        )
    }
}
