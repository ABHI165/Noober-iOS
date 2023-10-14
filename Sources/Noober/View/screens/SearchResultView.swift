import SwiftUI

struct SearchResultView: View {
    let state: FilteredDataState
    let sendAction: (UserAction) -> Void
    var body: some View {
        VStack {
            List {
                ForEach(state.apiCalls, id: \.id) { state in
                    NavigationLink {
                        APIDetailView(state: state) {msg in
                            sendAction(.tappedShare(msg: msg))
                        }
                    } label: {
                        APICallListItemView(state: state.summary)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                ForEach(state.userProperties, id: \.key) { state in
                    UserPropertiesCell(state: state){key, newVal in
                        sendAction(.tappedChangePrefValue(newVal: newVal, forKey: key))}
                }
                
                ForEach(state.logs, id: \.id) { state in
                    LogListItemView(state: state)
                }
            }
            .listStyle(.plain)
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    SearchResultView(state: .mocked) {_ in}
}
#endif
