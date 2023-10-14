import SwiftUI

struct APICallsTabView: View {
    let state: [APIInfoState]
    let onShareClicked: (String) -> Void
    
    var body: some View {
        VStack {
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
            
            Spacer()
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
       
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#if DEBUG
#Preview {
    NavigationView {
        APICallsTabView(state: [APIInfoState.mocked]) {_ in}
    }
}
#endif
