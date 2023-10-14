import SwiftUI

struct APISummaryState {
    let cURL: String
    let statusCode: String
    let timeout: String
    let timeInterval: String
    let responseTime: String
    let requestTime: String
    let url: String
    let method: String
    let cache: String
    let isSuccessfull: Bool
    let error:String?
}

//MARK: - Extension
extension APISummaryState {
    func matchesQuery(_ query: String) -> Bool {
        return statusCode.localizedCaseInsensitiveContains(query) ||
        url.localizedCaseInsensitiveContains(query) ||
        method.localizedCaseInsensitiveContains(query)
    }
}

#if DEBUG
extension APISummaryState {
    static let mocked = APISummaryState(cURL: "sfsfs",
                                        statusCode: "500",
                                        timeout: "03",
                                        timeInterval: "03",
                                        responseTime: "1",
                                        requestTime: "1",
                                        url: "www.api.com",
                                        method: "GET",
                                        cache: "No Cache",
                                        isSuccessfull: false,
                                        error: "Something went wrong")
}
#endif

