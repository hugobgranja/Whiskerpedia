import Foundation
import CatClientAPI
@testable import CatClientImpl
import CatClientMocks
import Testing

struct RestClientTests {
    struct User: Codable, Equatable {
        let name: String
        let birthDate: Date
    }

    enum Constants {
        static let url = URL(string: "http://localhost:8080")!
        static let acceptHeader = ["Accept": "application/json"]
        static let responseHeaders = ["Content-Type": "application/json"]

        static let user = User(
            name: "123",
            birthDate: Date.now.addingTimeInterval(3600)
        )
    }

    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    private let urlRequester = URLRequesterMock()
    private let sut: RestClient

    init() {
        self.sut = RestClientImpl(
            urlRequester: urlRequester,
            encoder: Self.encoder,
            decoder: Self.decoder
        )
    }

    @Test(
        "Request sending no data sends correct headers",
        arguments: [nil, [:], Constants.acceptHeader]
    )
    func requestSendingNoDataSendsCorrectHeaders(
        requestHeaders: [String: String]?
    ) async throws {
        // Act
        let _ = try await sut.request(
            url: Constants.url,
            method: .get,
            headers: requestHeaders
        )

        // Assert
        let requestedHeaders = try #require(urlRequester.requestedHeaders)
        let expectedHeaders = [:].mergingKeepingCurrent(requestHeaders)
        #expect(requestedHeaders == expectedHeaders)
    }

    @Test(
        "Request sending data sends correct headers",
        arguments: [nil, [:], Constants.acceptHeader]
    )
    func requestSendingDataSendsCorrectHeaders(
        requestHeaders: [String: String]?
    ) async throws {
        // Arrange
        let contentTypeHeader = ["Content-Type": "application/json"]

        // Act
        let _ = try await sut.request(
            url: Constants.url,
            method: .get,
            body: Constants.user,
            headers: requestHeaders
        )

        // Assert
        let requestedHeaders = try #require(urlRequester.requestedHeaders)
        let expectedHeaders = contentTypeHeader.mergingKeepingCurrent(requestHeaders)
        #expect(requestedHeaders == expectedHeaders)
    }

    @Test("Request throws on server error")
    func requestThrowsOnServerError() async throws {
        urlRequester.setResponseStatusCode(500)

        await #expect(
            throws: RestClientError.serverError(statusCode: 500),
            performing: {
                let _ = try await sut.request(
                    url: Constants.url,
                    method: .get,
                    body: Constants.user,
                    headers: [:]
                )
            }
        )
    }

    @Test("Request sends and returns expected values")
    func requestSendsAndReturnsAsExpected() async throws {
        // Arrange
        let userData = try Self.encoder.encode(Constants.user)
        urlRequester.setResponseData(userData)
        urlRequester.setResponseHeaders(Constants.responseHeaders)

        // Act
        let response = try await sut.request(
            url: Constants.url,
            method: .get,
            body: Constants.user,
            headers: [:]
        )

        //Assert
        #expect(urlRequester.requestedURL == Constants.url)
        #expect(urlRequester.requestedHTTPMethod == .get)

        let responseHeaders = try #require(response.headers)
        #expect(response.statusCode == 200)
        #expect(try response.decode(User.self) == Constants.user)
        #expect(responseHeaders.isEqual(to: Constants.responseHeaders))
    }
}
