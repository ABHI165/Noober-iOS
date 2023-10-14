import SwiftUI

struct EditUserPropertiesView: View {
    private let state: UserPropertiesState
    private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
    private let didTappedSave: (String, String) -> Void
    
    @State private var newPrefValue = ""
    @Environment(\.presentationMode) var presentationMode
    
    init(state: UserPropertiesState, didTappedSave: @escaping (String, String) -> Void) {
        self.state = state
        self.didTappedSave = didTappedSave
        impactFeedback.prepare()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "xmark")
                .font(.headline)
                .frame(width: 30, height: 30)
                .onTap {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            
            
            Divider()
            
            HStack {
                Text(state.key)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                
                Spacer()
                
                Text(state.valueType)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Blur(style: .systemThickMaterialDark))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.top, 8)
            
            if #available(iOS 16, *) {
                TextField(state.value, text: $newPrefValue, axis: .vertical)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .font(.system(size: 20))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.black)
                    )
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 3)
            } else {
                TextField(state.value, text: $newPrefValue)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .font(.system(size: 20))
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.black)
                    )
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 3)
            }
            
            Spacer()
            
            Button(action: {
                impactFeedback.impactOccurred()
                didTappedSave(state.key, newPrefValue)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .disabled(newPrefValue.isEmpty || newPrefValue.trimmingCharacters(in: .whitespaces).isEmpty)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(newPrefValue.isEmpty ? Color.gray :  Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
            })
            .padding(.bottom, 30)
            
        }
        .padding()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(
            ZStack {
                Color.orange.opacity(0.2)
                Blur(style: .systemMaterial)
            }
        )
        .onTap {
            hideKeyboard()
        }
        .edgesIgnoringSafeArea(.bottom)
        .colorScheme(.light)
    }
}

#if DEBUG
#Preview {
    EditUserPropertiesView(state: UserPropertiesState(key: "token", value: "Sfdfsdfds", valueType: "String")) {_, _ in
        
    }
}
#endif
