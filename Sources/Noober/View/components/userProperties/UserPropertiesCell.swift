import SwiftUI

struct UserPropertiesCell: View {
    let state: UserPropertiesState
    let didTappedSave: (String, String) -> Void
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(state.key)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
            
            Divider()
                .padding(.horizontal)
            
            Text(state.value)
                .font(.system(size: 14))
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.gray)
        )
        .background(Color.gray.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTap {
            isSheetPresented.toggle()
        }
        .shadow(color: .black.opacity(0.03), radius: 4, x: 3, y: 3)
        .sheet(isPresented: $isSheetPresented) {
            EditUserPropertiesView(state: state, didTappedSave: didTappedSave)
        }
    }
    
    
}

#if DEBUG
#Preview {
    UserPropertiesCell(state: .mocked) {_, _ in
        
    }
}
#endif
