import SwiftUI

struct UserPropertiesTabView: View {
    let state: [UserPropertiesState]
    let didTappedSave: (String, String) -> Void
    
    var body: some View {
        List {
            ForEach(state, id: \.key) { state in
                UserPropertiesCell(state: state, didTappedSave: didTappedSave)
            }
        }
        .listStyle(.plain)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.bottom, 50)
    }
}

#if DEBUG
#Preview {
    UserPropertiesTabView(state: [UserPropertiesState.mocked]) { _, _ in}
}
#endif
