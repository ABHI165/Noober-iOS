import Foundation

//MARK: - RequestModel
struct RequestModel {
    let baseURL: String
    let curl: String
    let header: [String:String]
    let body: String
    let date: Date
    let method: String
    let timeout: String
    let cachePolicy: String
    
    init(baseURL: String = "_", curl: String = "_", header: [String : String] = [:], body: String = "_", date: Date = Date(), method: String = "_", timeout: String = "_", cachePolicy: String = "_") {
        self.baseURL = baseURL
        self.curl = curl
        self.header = header
        self.body = body
        self.date = date
        self.method = method
        self.timeout = timeout
        self.cachePolicy = cachePolicy
    }
}

extension RequestModel {
    //MARK:  makeRequestModelWith
    static func makeRequestModelWith(_ request: URLRequest) -> RequestModel {
        return RequestModel(
            baseURL: request.getURL(),
            curl: request.getCurl(),
            header: request.getHeaders(),
            body: request.getBody().toString(),
            date: Date(),
            method: request.getHttpMethod(),
            timeout: request.getTimeout(),
            cachePolicy: request.getCachePolicy())
    }
    
    func convertToState() -> HeaderBodyState {
        HeaderBodyState(
            headers: header,
            body: body)
    }
}
