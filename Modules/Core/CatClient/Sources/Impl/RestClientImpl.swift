import Foundation
import CatClientAPI

public final class RestClientImpl: RestClient {
    private let urlRequester: URLRequester
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        urlRequester: URLRequester,
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) {
        self.urlRequester = urlRequester
        self.encoder = encoder
        self.decoder = decoder
    }

    public func request(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable? = nil,
        headers: [String: String]? = nil
    ) async throws -> Response {
        let request = try makeRequest(
            url: url,
            method: method,
            encodableBody: encodableBody,
            headers: headers
        )

        let (data, response) = try await urlRequester.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw RestClientError.invalidResponse
        }

        try validateResponse(statusCode: response.statusCode)

        return ResponseImpl(
            data: data,
            statusCode: response.statusCode,
            headers: response.allHeaderFields,
            decoder: decoder
        )
    }

    private func makeRequest(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable?,
        headers: [String: String]?
    ) throws -> URLRequest {
        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let encodableBody {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(encodableBody)
        }

        // Set headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }

    private func validateResponse(statusCode: Int) throws {
        if !((200...299) ~= statusCode) {
            throw RestClientError.serverError(statusCode: statusCode)
        }
    }
}
