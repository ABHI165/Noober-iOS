import Foundation

//MARK: - ResponseModel
struct ResponseModel {
    let header: [String:String]
    let body: String
    let date: String
    let statusCode: Int
    let timeInterval: Float
    let error: String?
    
    init(header: [String : String] = [:], body: String = "_", date: String = "_", statusCode: Int = -1, timeInterval: Float = 0, error: String? = nil) {
        self.header = header
        self.body = body
        self.date = date
        self.statusCode = statusCode
        self.timeInterval = timeInterval
        self.error = error
    }
}


extension ResponseModel {
    //MARK: makeResponseModelWith
    static func toModelWith(_ response: URLResponse?, data: Data, requestTime: Date, error: String?) -> ResponseModel {
        let date = Date()
        print("request -> \(requestTime) response \(date) diff \( Float(date.timeIntervalSince(requestTime)))")
        return ResponseModel(
            header: response?.getHeaders() ?? [:],
            body: data.toString(),
            date: date.getTime() ?? "\(date)",
            statusCode: response?.getStatus() ?? -1,
            timeInterval: Float(date.timeIntervalSince(requestTime)),
            error: error)
    }
    
    func convertToState() -> HeaderBodyState {
        HeaderBodyState(
            headers: header,
            body: body)
    }
}
