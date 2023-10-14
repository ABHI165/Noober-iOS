import SwiftUI

struct LogsTabView: View {
    let state: [LogState]
    
    var body: some View {
        VStack {
            List {
                ForEach(state, id: \.id) { state in
                   LogListItemView(state: state)
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
    LogsTabView(state: [.mocked])
}
#endif
