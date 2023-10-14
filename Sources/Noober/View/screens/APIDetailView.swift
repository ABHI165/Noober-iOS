import SwiftUI

struct APIDetailView: View {
    let state: APIInfoState
    let onClickedShare: (String) -> Void
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Summary", "Request", "Response"])
            
            ZStack {
                APISummaryView(state: state.summary)
                    .opacity(selectedTabIndex == 0 ? 1 : 0)
                
                RequestResponseView(state: state.requestState, onClickedShare: onClickedShare)
                    .opacity(selectedTabIndex == 1 ? 1 : 0)
                
                RequestResponseView(state: state.responseState, onClickedShare: onClickedShare)
                    .opacity(selectedTabIndex == 2 ? 1 : 0)
            }
            
            
            Spacer()
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
        .animation(.none) 
        .navigationBarTitle("API Detail")
    }
}

#if DEBUG
#Preview {
    NavigationView {
        APIDetailView(state: .mocked) {_ in }
    }
}
#endif
