import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearchable: Bool
    
    var body: some View {
        HStack {
            TextField("Search API, Logs, Properties", text: $searchText)
                .font(.system(size: 16))
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            
            Image(systemName: "xmark")
                .frame(width: 30, height: 30)
                .onTap {
                    withAnimation(.bouncy) {
                        isSearchable = false
                    }
                    Haptic.toggleFeedback()
                    hideKeyboard()
                }
        }
        .padding()
    }
}

#if DEBUG
#Preview {
    SearchBarView(searchText: .constant(""), isSearchable: .constant(true))
}
#endif
