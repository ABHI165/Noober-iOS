import SwiftUI

struct APISummaryView: View {
    let state: APISummaryState
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SummaryItemView(title: "cURL", subTitle: state.cURL)
                SummaryItemView(title: "Status Code", subTitle: state.statusCode, isError: !state.isSuccessfull)
                SummaryItemView(title: "Method", subTitle: state.method)
                SummaryItemView(title: "URL", subTitle: state.url)
                SummaryItemView(title: "Response Time", subTitle: state.responseTime)
                SummaryItemView(title: "Request Time", subTitle: state.requestTime)
                SummaryItemView(title: "Time Interval ", subTitle: state.timeInterval)
                SummaryItemView(title: "Timeout", subTitle: state.timeout)
                SummaryItemView(title: "Cache Policy", subTitle: state.cache)
                SummaryItemView(title: "Error", subTitle: state.error ?? "_", isError: true)
            }
            .padding()
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
    }
}

#if DEBUG
#Preview {
    APISummaryView(state: APISummaryState.mocked)
}
#endif
