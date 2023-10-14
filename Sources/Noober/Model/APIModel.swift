import Foundation

struct APIModel {
    let request: RequestModel
    let response: ResponseModel
}

extension APIModel {
    func convertToState() -> APIInfoState {
        let requestState = request.convertToState()
        let responseState = response.convertToState()
        
        let summaryState = APISummaryState(
            cURL: request.curl,
            statusCode: String(describing: response.statusCode),
            timeout: request.timeout,
            timeInterval: String(describing: response.timeInterval),
            responseTime: response.date,
            requestTime: request.date.getTime() ?? "\(request.date)",
            url: request.baseURL,
            method: request.method,
            cache: request.cachePolicy,
            isSuccessfull: (response.statusCode < 400),
            error: response.error)
        
        return APIInfoState(
            summary: summaryState,
            requestState: requestState,
            responseState: responseState)
    }
}
