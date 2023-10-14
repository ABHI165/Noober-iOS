import SwiftUI


struct MoreTabView: View {
    @State private var oldURl: String = Noober.shared.oldURL
    @State private var newURL: String =  Noober.shared.newReplacedURL
    let sendAction: (UserAction) -> Void
    
    
    var body: some View {
        Form {
            Section(
                header: Text("Base URL")) {
                    URLSection()
                }
            
            Section(
                header: Text("Account")
            ) {
                AccountSection()
                    .padding(.vertical, 2)
            }
            
            Section {
                Button("Report 🐞") {
                    Haptic.errorFeedback()
                    sendAction(.tappedContribute)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    @ViewBuilder
    private func URLSection() -> some View {
        VStack {
            HStack {
                Text("Replace")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                Divider()
                TextField("apistaginig.com", text: $oldURl)
                    .lineLimit(1)
                    .textContentType(.URL)
            }
            
            Divider()
            
            HStack {
                Text("With")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                Divider()
                TextField("apiprod.com", text: $newURL)
                    .lineLimit(1)
                    .textContentType(.URL)
            }
            
            
            Button("Save") {
                Haptic.successFeedback()
                sendAction(.tappedChangeURL(newURL: newURL, oldURL: oldURl))
                hideKeyboard()
            }
            .font(.headline)
            .padding()
            .disabled(oldURl.isEmpty || newURL.isEmpty)
        }
    }
    
    @ViewBuilder
    private func AccountSection() -> some View {
        HStack {
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
                sendAction(.tappedShareAccount)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            
            HStack {
                Image(systemName: "gobackward")
                Text("Restore")
            }
            .padding(6)
            .background(Blur(style: .systemThinMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .onTap {
                Haptic.successFeedback()
                sendAction(.tappedRestoreAccount)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

#if DEBUG
#Preview {
    MoreTabView() { _ in}
}
#endif
