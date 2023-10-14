import SwiftUI

struct LogsTabView: View {
    let state: [LogState]
    
    var body: some View {
        List {
            ForEach(state, id: \.id) { state in
                LogListItemView(state: state)
            }
        }
        .listStyle(.plain)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.bottom, 50)
    }
}

#if DEBUG
#Preview {
    LogsTabView(state: [.mocked])
}
#endif
