import Foundation
import CatClientAPI
@testable import CatClientImpl
import CatClientMocks
import Testing

struct CatClientTests {
    enum Constants {
        static let url = URL(string: "http://localhost:8080")!
        static let acceptHeader = ["Accept": "application/json"]
        static let apiKey = "12345"
        static let apiHeader = ["x-api-key": Self.apiKey]
    }

    private let baseClient: RestClientMock
    private let sut: CatClient

    init() {
        self.baseClient = RestClientMock()

        self.sut = CatClientImpl(
            client: baseClient,
            apiKey: Constants.apiKey
        )
    }

    @Test(
        "Request sends api key in header",
        arguments: [nil, [:], Constants.acceptHeader]
    )
    func requestSendsApiKey(requestHeaders: [String: String]?) async throws {
        // Act
        let _ = try await sut.request(
            url: Constants.url,
            method: .get,
            headers: requestHeaders
        )

        // Assert
        let requestedHeaders = try #require(baseClient.requestedHeaders)
        let expectedHeaders = Constants.apiHeader.mergingKeepingCurrent(requestHeaders)
        #expect(requestedHeaders == expectedHeaders)
    }
}
