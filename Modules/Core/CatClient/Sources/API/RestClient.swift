import Foundation

public protocol RestClient: Sendable {
    func request(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable?,
        headers: [String: String]?
    ) async throws -> Response
}

public extension RestClient {
    func request<T: Encodable>(
        url: URL,
        method: HTTPMethod,
        body: T,
        headers: [String: String]? = nil
    ) async throws -> Response {
        return try await request(
            url: url,
            method: method,
            encodableBody: AnyEncodable(body),
            headers: headers
        )
    }

    func request(
        url: URL,
        method: HTTPMethod
    ) async throws -> Response {
        return try await request(
            url: url,
            method: method,
            encodableBody: nil,
            headers: nil
        )
    }

    func request(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable?
    ) async throws -> Response {
        return try await request(
            url: url,
            method: method,
            encodableBody: encodableBody,
            headers: nil
        )
    }

    func request(
        url: URL,
        method: HTTPMethod,
        headers: [String: String]?
    ) async throws -> Response {
        return try await request(
            url: url,
            method: method,
            encodableBody: nil,
            headers: headers
        )
    }
}
