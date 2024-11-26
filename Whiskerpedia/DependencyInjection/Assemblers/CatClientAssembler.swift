import Foundation
import BackpackDI
import CatClientAPI
import CatClientImpl

@MainActor
public final class CatClientAssembler {
    static func assemble(_ container: Container) {
        container.register(RestClient.self) { _ in
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()

            return RestClientImpl(
                urlRequester: URLSession.shared,
                encoder: encoder,
                decoder: decoder
            )
        }

        container.register(CatClient.self) { r in
            CatClientImpl(
                client: r.resolve(RestClient.self),
                apiKey: r.resolve(AppConfig.self).catServiceApiKey
            )
        }
    }
}
