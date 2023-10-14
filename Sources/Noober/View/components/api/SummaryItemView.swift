import SwiftUI

struct SummaryItemView: View {
    let title: String
    let subTitle: String
    let isError: Bool
    
    init(title: String, subTitle: String, isError: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.isError = isError
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .foregroundColor(.black)
            
            Text(subTitle)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(isError ? Color.red : Color.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    SummaryItemView(title: "dfgfgfgf", subTitle: "d", isError: false)
}
#endif
