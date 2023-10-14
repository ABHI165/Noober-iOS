import Foundation

struct LogModel {
    let title: String
    let description: String
    let isError: Bool
    let date = Date()
}


extension LogModel {
    func convertToState() -> LogState {
        LogState(
            title: title,
            description: description,
            isError: isError,
            date: date.getTime() ?? "\(date)")
    }
}
