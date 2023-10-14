import SwiftUI

struct RequestResponseView: View {
    let state: HeaderBodyState
    let onClickedShare: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if !state.headers.isEmpty {
                    Text("Headers")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .padding(8)
                       
                    Divider()
                        .padding(.top, -12)
                    
                    ForEach(state.headers.sorted(by: <), id: \.key) { header in
                        SummaryItemView(title: header.key, subTitle: header.value)
                    }
                }
                
                
                if !state.body.isEmpty {
                    Text("Body")
                        .foregroundColor(.gray)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .padding(8)
                        .padding(.top, 24)
                   
                    Divider()
                        .padding(.top, -12)
                    
                    
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .onTap {
                        Haptic.successFeedback()
                        onClickedShare(state.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text(state.body)
                        .font(.system(size: 16, weight: .bold, design: .serif))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                        .background(
                            ZStack {
                                Color.gray.opacity(0.6)
                                Blur(style: .systemUltraThinMaterial)
                            }
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        )
                        .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 2).fill(Color.black))
                    
                }
                
                if state.headers.isEmpty && state.body.isEmpty {
                    Text("Nothing to see here!")
                        .font(.caption)
                }
                
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            
        }
    }
}

#if DEBUG
#Preview {
    RequestResponseView(state: HeaderBodyState.mocked) {_ in}
}
#endif
