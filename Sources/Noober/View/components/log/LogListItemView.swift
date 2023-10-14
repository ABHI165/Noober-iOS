import SwiftUI

struct LogListItemView: View {
    let state: LogState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(state.title)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(state.isError ? .white : .black)
            
            Divider()
                .padding(.horizontal)
            
            Text(state.description)
                .font(.system(size: 14))
            
            Text(state.date)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.gray)
        )
        .background(state.isError ? Color.red : Color.white)
        .clipShape( RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 3)
    }
}

#if DEBUG
#Preview {
    LogListItemView(state: .mocked)
}
#endif
