import Foundation

public enum RestClientError: Error, Equatable {
    case serverError(statusCode: Int)
    case invalidResponse
}
