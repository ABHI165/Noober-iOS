import Foundation

open class NoobProtocol: URLProtocol {
    private static let KEY = String(describing: NoobProtocol.self)
    
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    private let repository = NoobRepository.shared
    private var responseData: NSMutableData?
    private var httpResponse: URLResponse?
    private var requestModel = RequestModel()
    private var responseModel = ResponseModel()
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return canServeRequest(request)
    }
    
    override open class func canInit(with task: URLSessionTask) -> Bool {
        guard let request = task.originalRequest else {return false}
        return canServeRequest(request)
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    private class func canServeRequest(_ request: URLRequest) -> Bool {
        let url = request.url?.absoluteString ?? ""
        guard ((url.starts(with: "https") || url.starts(with: "http")) && URLProtocol.property(forKey: self.KEY, in: request) == nil && NoobHelper.shared.hasStarted) else {return false}
        return !Noober.shared.ignoredURLs.contains(where: {$0 == url})
    }
    
    
    override open func startLoading() {
        let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        if !Noober.shared.oldURL.isEmpty && !Noober.shared.newReplacedURL.isEmpty, let oldUrl = mutableRequest.url?.absoluteString {
            mutableRequest.url = URL(string: oldUrl.replacingOccurrences(of: Noober.shared.oldURL, with: Noober.shared.newReplacedURL))
        }
        URLProtocol.setProperty(true, forKey: NoobProtocol.KEY, in: mutableRequest)
        requestModel = RequestModel.makeRequestModelWith(mutableRequest as URLRequest)
        session.dataTask(with: mutableRequest as URLRequest).resume()
    }
    
    override open func stopLoading() {
        session.getTasksWithCompletionHandler { dataTasks, _, _ in
            dataTasks.forEach { $0.cancel() }
        }
    }
}

extension NoobProtocol: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        httpResponse = response
        responseData = NSMutableData()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData?.append(data)
        client?.urlProtocol(self, didLoad: data)
    }
    
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        defer {
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocolDidFinishLoading(self)
            }
        }
        let data = (responseData ?? NSMutableData()) as Data
        
        responseModel = ResponseModel.toModelWith(httpResponse, data: data, requestTime: requestModel.date, error: error?.localizedDescription)
        let apiModel = APIModel(request: requestModel, response: responseModel)
        repository.addAPIModel(apiModel)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        let updatedRequest: URLRequest
        if URLProtocol.property(forKey: NoobProtocol.KEY, in: request) != nil {
            let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            URLProtocol.removeProperty(forKey: NoobProtocol.KEY, in: mutableRequest)
            
            updatedRequest = mutableRequest as URLRequest
        } else {
            updatedRequest = request
        }
        
        client?.urlProtocol(self, wasRedirectedTo: updatedRequest, redirectResponse: response)
        completionHandler(updatedRequest)
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let wrappedChallenge = URLAuthenticationChallenge(authenticationChallenge: challenge, sender: NoobAuthenticationManager(handler: completionHandler))
        client?.urlProtocol(self, didReceive: wrappedChallenge)
    }
}


