import Foundation
import CatClientAPI

public final class CatClientImpl: CatClient {
    private let client: RestClient
    private let apiKey: String

    public init(
        client: RestClient,
        apiKey: String
    ) {
        self.client = client
        self.apiKey = apiKey
    }

    public func request(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable?,
        headers: [String: String]?
    ) async throws -> Response {
        var newHeaders = headers ?? [:]

        newHeaders["x-api-key"] = apiKey

        return try await client.request(
            url: url,
            method: method,
            encodableBody: encodableBody,
            headers: newHeaders
        )
    }
}
