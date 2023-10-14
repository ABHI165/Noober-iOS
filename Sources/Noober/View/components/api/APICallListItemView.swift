import SwiftUI

struct APICallListItemView: View {
    let state: APISummaryState
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 4){
                Text(state.statusCode)
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(state.isSuccessfull ? Color.green : Color.red)
                Text(state.method)
                    .font(.system(size: 18, weight: .semibold, design: .monospaced))
                    .foregroundColor(state.isSuccessfull ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
            }
            .padding()
            .background(state.isSuccessfull ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(state.url)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                
                Divider()
                Text(state.requestTime)
                    .font(.footnote)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            }
            
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).fill(state.isSuccessfull ? Color.green.opacity(0.2) : Color.red.opacity(0.2)))
    }
}

#if DEBUG
#Preview {
    APICallListItemView(state: APISummaryState.mocked)
        .padding(.horizontal)
}
#endif
