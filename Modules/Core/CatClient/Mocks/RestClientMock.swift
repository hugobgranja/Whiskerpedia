import Foundation
import CatClientAPI

public final class RestClientMock: RestClient, @unchecked Sendable {
    // Mock
    public var data: Data = Data()
    public var statusCode = 200
    public var headers = [String: String]()
    public var decodedData: Any?

    // Spy
    private(set) public var requestedURL: URL?
    private(set) public var requestedHTTPMethod: HTTPMethod?
    private(set) public var requestedHeaders: [String: String]?

    public init() {}

    public func request(
        url: URL,
        method: HTTPMethod,
        encodableBody: AnyEncodable?,
        headers: [String : String]?
    ) async throws -> Response {
        self.requestedURL = url
        self.requestedHTTPMethod = method
        self.requestedHeaders = headers

        return ResponseMock(
            data: data,
            statusCode: statusCode,
            headers: headers,
            decodedData: decodedData
        )
    }
}
