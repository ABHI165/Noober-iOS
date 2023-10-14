import SwiftUI

struct UserPropertiesTabView: View {
    let state: [UserPropertiesState]
    let didTappedSave: (String, String) -> Void
    
    var body: some View {
        VStack {
            List {
                ForEach(state, id: \.key) { state in
                    UserPropertiesCell(state: state, didTappedSave: didTappedSave)
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
    UserPropertiesTabView(state: [UserPropertiesState.mocked]) { _, _ in}
}
#endif
