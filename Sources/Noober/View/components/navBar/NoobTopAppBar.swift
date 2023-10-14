import SwiftUI

struct NoobTopAppBar: View {
    @Binding var isSearching: Bool
    @Binding var text: String
    
    var body: some View {
        VStack {
            if isSearching {
                SearchBarView(searchText: $text, isSearchable: $isSearching)
                    .transition(.move(edge: .trailing))
            } else {
                HStack {
                    Text("Noober")
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                    
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 30, height: 30)
                        .onTap {
                            withAnimation(.bouncy) {
                                isSearching = true
                            }
                            Haptic.toggleFeedback()
                        }
                }
                .padding()
                .transition(.move(edge: .leading))
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    NoobTopAppBar(isSearching: .constant(true), text: .constant("true"))
}
#endif
