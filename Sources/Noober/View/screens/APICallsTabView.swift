import SwiftUI

struct APICallsTabView: View {
    let state: [APIInfoState]
    let onShareClicked: (String) -> Void
    
    var body: some View {
        List {
            ForEach(state, id: \.id) { state in
                NavigationLink {
                    APIDetailView(state: state, onClickedShare: onShareClicked)
                } label: {
                    APICallListItemView(state: state.summary)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(.plain)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.bottom, 50)
    }
}

#if DEBUG
#Preview {
    NavigationView {
        APICallsTabView(state: [APIInfoState.mocked]) {_ in}
    }
}
#endif
