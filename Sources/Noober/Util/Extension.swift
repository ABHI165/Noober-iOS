import UIKit

//MARK: - UIWindow
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake && NoobHelper.shared.hasStarted {
            NoobHelper.shared.toggle()
        }
    }
}


//MARK: - URLRequest
extension URLRequest {
    
    func getTimeout() -> String {
        return String(Double(timeoutInterval))
    }
    
    func getBody() -> Data {
        
        guard let bodyStream = self.httpBodyStream else { return Data() }
        
        bodyStream.open()
        let bufferSize: Int = 16
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        var dat = Data()
        
        while bodyStream.hasBytesAvailable {
            
            let readDat = bodyStream.read(buffer, maxLength: bufferSize)
            dat.append(buffer, count: readDat)
        }
        
        buffer.deallocate()
        
        bodyStream.close()
        
        return dat
    }
    
    func getURL() -> String {
        guard let url = self.url else {
            return ""
        }
        return url.absoluteString
    }
    
    func getURLComponents() -> URLComponents? {
        guard let url = self.url else {
            return nil
        }
        return URLComponents(string: url.absoluteString)
    }
    
    func getHttpMethod() -> String {
        
        guard let method = self.httpMethod else {
            return ""
        }
        return method
    }
    
    func getCachePolicy() -> String {
        switch cachePolicy {
            case .useProtocolCachePolicy: return "UseProtocolCachePolicy"
            case .reloadIgnoringLocalCacheData: return "ReloadIgnoringLocalCacheData"
            case .reloadIgnoringLocalAndRemoteCacheData: return "ReloadIgnoringLocalAndRemoteCacheData"
            case .returnCacheDataElseLoad: return "ReturnCacheDataElseLoad"
            case .returnCacheDataDontLoad: return "ReturnCacheDataDontLoad"
            case .reloadRevalidatingCacheData: return "ReloadRevalidatingCacheData"
            @unknown default: return "Unknown \(cachePolicy)"
        }
    }
    func getHeaders() -> [String: String] {
        return allHTTPHeaderFields ?? [:]
    }
    
    func getCurl() -> String {
        guard let url = url else { return "" }
        let baseCommand = "curl \(url.absoluteString)"
        
        var command = [baseCommand]
        
        if let method = httpMethod {
            command.append("-X \(method)")
        }
        
        getHeaders().forEach { header in
            command.append("-H \u{22}\(header.key): \(header.value)\u{22}")
        }
        
        if let body = String(data: getBody(), encoding: .utf8), !body.isEmpty {
            command.append("-d \u{22}\(body)\u{22}")
        }
        
        return command.joined(separator: " ")
    }
    
}


//MARK: - URLResponse
extension URLResponse {
    func getStatus() -> Int {
        return (self as? HTTPURLResponse)?.statusCode ?? 999
    }
    
    func getHeaders() -> [String: String] {
        let headers =  (self as? HTTPURLResponse)?.allHeaderFields ?? [:]
        let outputDictionary = headers.compactMap { (key, value) in
            if let keyString = key as? String, let valueString = value as? String {
                return (keyString, valueString)
            } else {
                return nil
            }
        }
        return Dictionary(uniqueKeysWithValues: outputDictionary)
    }
    
}


//MARK: - Data
extension Data {
    func toString() -> String {
        do {
            let rawJsonData = try JSONSerialization.jsonObject(with: self, options: [])
            let prettyPrintedString = try JSONSerialization.data(withJSONObject: rawJsonData, options: [.prettyPrinted])
            return String(data: prettyPrintedString, encoding: String.Encoding.utf8) ?? ""
        } catch {
            return String(data: self, encoding: .utf8) ?? ""
        }
    }
}


//MARK: - Date
extension Date {
    func getTime() -> String? {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.hour, .minute], from: self)
        guard let hour = components.hour, let minutes = components.minute else {
            return nil
        }
        if minutes < 10 {
            return "\(hour):0\(minutes)"
        } else {
            return "\(hour):\(minutes)"
        }
    }
}


//MARK: - Haptic
struct Haptic {
    
    static func successFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    static func errorFeedback() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    static func toggleFeedback() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

